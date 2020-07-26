SKIP_DEPS=yaws|ltest
SKIP_INCS=goldrush|yaws

PUB_DEPS=$(shell \
find deps -type d -maxdepth 1 -mindepth 1 -exec echo "{}/ebin/*" \;| \
egrep -v '$(SKIP_DEPS)'| \
tr '\n' ',')

PUB_INCS=$(shell \
find deps -type d -maxdepth 1 -mindepth 1 -exec echo "{}/include/*.*" \;| \
egrep -v '$(SKIP_INCS)'| \
tr '\n' ',')

REMOTE_HOST=cnbbooks.co
REMOTE_STATIC_DIR=/more-www/cnbb/html
REMOTE_EBIN_DIR=/more-www/cnbb/ebin
REMOTE_INCLUDE_DIR=/more-www/cnbb/include
REMOTE_CONTENT_DIR=/more-www/cnbb/content

publish: compile
	rsync -vazP {www/css,www/js,www/images,www/fonts} \
	$(REMOTE_HOST):$(REMOTE_STATIC_DIR)
	rsync -vazP {$(PUB_DEPS)ebin/*} \
	$(REMOTE_HOST):$(REMOTE_EBIN_DIR)
	rsync -vazP {$(PUB_INCS)$()include/*} \
	$(REMOTE_HOST):$(REMOTE_INCLUDE_DIR)
	rsync -vazP content/* \
	$(REMOTE_HOST):$(REMOTE_CONTENT_DIR)
