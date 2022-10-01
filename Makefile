BIN = zola
AWS_BIN = aws
GEN := $(shell which $(BIN) 2> /dev/null)
DEPLOYER := $(shell which $(AWS_BIN) 2> /dev/null)
DOWNLOAD = https://github.com/rust-lang/mdBook/releases
PUBLISH_DIR = site
PUBLISH_BRANCH = master
BUILDER_BRANCH = builder
TMP_GIT_DIR = /tmp/cnbb-site-git
PORT = 5099
AWS_PROFILE = cnbb
S3_BUCKET = s3://books.cnbb.pub
S3_REGION = us-east-2
S3_ENDPOINT = $(S3_BUCKET).s3-website.$(S3_REGION).amazonaws.com

define ZOLA_BINARY_ERROR

No $(BIN) found in Path.

Install $(BIN):

	$ brew install $(BIN)

endef

define AWS_BINARY_ERROR

No $(AWS_BIN) found in Path.

Install $(AWS_BIN):

	$ brew install awscli

endef

build:
ifndef GEN
	$(error $(ZOLA_BINARY_ERROR))
endif
	@$(GEN) build -o $(PUBLISH_DIR)

serve:
	@$(GEN) serve -o $(PUBLISH_DIR) -p $(PORT)

run: serve

clean:
	@rm -rf $(PUBLISH_DIR)

book-init:
	@git submodule update --init --recursive

backup-book-git:
	@mkdir -p $(TMP_GIT_DIR)/
	@mv -v $(PUBLISH_DIR)/.git $(TMP_GIT_DIR)/

restore-book-git:
	@mv -v $(TMP_GIT_DIR)/.git $(PUBLISH_DIR)/

$(PUBLISH_DIR)/README.md:
	@echo '# Content for the books.cnbb.pub site > $(PUBLISH_DIR)/README.md
	@echo 'Published at [books.cnbb.pub/](http://books.cnbb.pub/)' >> $(PUBLISH_DIR)/README.md
	@cd $(PUBLISH_DIR) && git add README.md

commit:
	@git add content/* templates/*
	@git commit -am "Updated site content." > /dev/null
	git push origin $(BUILDER_BRANCH)

publish:
ifndef DEPLOYER
	$(error $(AWS_BINARY_ERROR))
endif
	@$(AWS_BIN) --profile=$(AWS_PROFILE) --region=$(S3_REGION) \
		s3 sync $(PUBLISH_DIR)/ $(S3_BUCKET)

build-publish: clean build commit publish

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
