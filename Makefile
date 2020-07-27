BIN = zola
GEN := $(shell which $(BIN) 2> /dev/null)
DOWNLOAD = https://github.com/rust-lang/mdBook/releases
PUBLISH_DIR = site
PUBLISH_BRANCH = master
BUILDER_BRANCH = builder
TMP_GIT_DIR = /tmp/cnbb-site-git
PORT = 5099
AWS_PROFILE = cnbb
S3_BUCKET = s3://cnbb.pub
S3_REGION = eu-north-1
S3_ENDPOINT = $(S3_BUCKET).s3-website.$(S3_REGION).amazonaws.com

define BINARY_ERROR

No $(BIN) found in Path.

Install $(BIN):

	$ brew install $(BIN)

endef

build:
ifndef GEN
	$(error $(BINARY_ERROR))
endif
	# $(MAKE) backup-book-git
	@$(GEN) build -o $(PUBLISH_DIR)
	# $(MAKE) restore-book-git

serve:
	# $(MAKE) backup-book-git
	@$(GEN) serve -p $(PORT)
	# $(MAKE) restore-book-git

run: serve

clean:
	@rm -f $(PUBLISH_DIR)/README.md

book-init:
	@git submodule update --init --recursive

backup-book-git:
	@mkdir -p $(TMP_GIT_DIR)/
	@mv -v $(PUBLISH_DIR)/.git $(TMP_GIT_DIR)/

restore-book-git:
	@mv -v $(TMP_GIT_DIR)/.git $(PUBLISH_DIR)/

$(PUBLISH_DIR)/README.md:
	@echo '# Content the cnbb.pub site > $(PUBLISH_DIR)/README.md
	@echo 'Published at [cnbb.pub/](http://cnbb.pub/)' >> $(PUBLISH_DIR)/README.md
	@cd $(PUBLISH_DIR) && git add README.md

commit: clean build $(PUBLISH_DIR)/README.md
	-@cd $(PUBLISH_DIR) && \
	git add * && \
	git commit -am "Regenerated site content." > /dev/null && \
	git push origin $(PUBLISH_BRANCH) && \
	cd -  && \
	git add $(PUBLISH_DIR) && \
	git commit -am "Updated submodule for recently generated site content." && \
	git submodule update && \
	git push origin $(BUILDER_BRANCH)

publish:
	aws --profile=$(AWS_PROFILE) --region=$(S3_REGION) \
		s3 sync $(PUBLISH_DIR)/ $(S3_BUCKET)

build-publish: build commit publish

spell-check:
	@for FILE in `find . -name "*.md"`; do \
	RESULTS=$$(cat $$FILE | aspell -d en_GB --mode=markdown list | sort -u | sed -e ':a' -e 'N;$$!ba' -e 's/\n/, /g'); \
	if [[ "$$RESULTS" != "" ]] ; then \
	echo "Potential spelling errors in $$FILE:"; \
	echo "$$RESULTS" | \
	sed -e 's/^/    /'; \
	echo; \
	fi; \
	done

add-word: WORD ?= ""
add-word:
	@echo "*$(WORD)\n#" | aspell -a

add-words: WORDS ?= ""
add-words:
	@echo "Adding words:"
	@for WORD in `echo $(WORDS)| tr "," "\n"| tr "," "\n" | sed -e 's/^[ ]*//' | sed -e 's/[ ]*$$//'`; \
	do echo "  $$WORD ..."; \
	echo "*$$WORD\n#" | aspell -a > /dev/null; \
	done
	@echo

spell-suggest:
	@for FILE in `find . -name "*.md"`; do \
	RESULTS=$$(cat $$FILE | aspell -d en_GB --mode=markdown list | sort -u ); \
	if [[ "$$RESULTS" != "" ]] ; then \
	echo "Potential spelling errors in $$FILE:"; \
	for WORD in $$RESULTS; do \
	echo $$WORD| aspell -d en_GB pipe | tail -2|head -1 | sed -e 's/^/    /'; \
	done; \
	echo; \
	fi; \
	done
