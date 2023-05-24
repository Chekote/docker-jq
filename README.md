# docker-jq
Docker image for the [jq](https://stedolan.github.io/jq/) command

## Dist:
The image is hosted on Docker Hub at https://hub.docker.com/r/chekote/jq.

## Usage:
This image is built on the [Chekote/alpine](https://hub.docker.com/r/chekote/alpine) image. Please see that [project's README](https://github.com/Chekote/docker-alpine#readme) for more information.

See `bin/jq` for a simple `docker run` command that will run jq with the provided arguments.

For seamless usage of the command as if it is installed as a native app, create the same `bin/jq` script in your path and make it executable.

Note: The default working directory is `/workdir`. But ideally you should use relative paths when asking jq to process files. This will only work if the file is within the current working directory or a subdirectory of it. If you wish to use absolute paths, you will need to mount the directory containing the file to the same path within the container.

e.g:

```gherkin
Given there is a file `/home/user/documents/test.json`
And the working dir is `/home/user`
And you have mounted the working dir to `/workdir` as in the `/bin/jq` example
When you run jq with a relative path like so `jq .your.query documents/test.json`
Then the command will behave as expected
```

However, if you run the command with an absolute path, it will fail:

```gherkin
Given there is a file `/home/user/documents/test.json`
And the working dir is `/home/user`
And you have mounted the working dir to `/workdir` as in the `/bin/jq` example
When you run jq with an absolute path like so `jq .your.query /home/user/documents/test.json`
Then the command will fail because it cannot find the file
```

So for this case, you must mount the directory containing the file to the same path within the container:

```gherkin
Given there is a file `/home/user/documents/test.json`
And the working dir is `/home/user`
And you have mounted `/home/user/documents/` to `/home/user/documents/` in the container
When you run jq with an absolute path like so `jq .your.query /home/user/documents/documents/test.json`
Then the command will behave as expected
```