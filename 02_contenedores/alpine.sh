# Alpine example

# "docker pull alpine" also works
docker image pull alpine

# TRY to run a bash inside new alpine container
docker container run -it alpine bash

# Past command will throw an error, because "bash" it's not into the image instructions.

# Run an interactive shell into a new Alpine container
# "docker container run -it alpine sh" also  works, because image doesn't have bash, but have "sh" (a smaller and not so full-featured shell)
docker container run -it --name alpine alpine

# Note: The package manager for Alpine is APK and we can install bash if needed