FROM chekote/alpine:latest

RUN set -eux; \
    #
    # Update all packages
    apk update; \
    apk upgrade; \
    #
    # Install jq
    apk add jq; \
	#
    # verify that the binary works
	su-exec echo '{"message":"It works!"}' | jq .message; \
