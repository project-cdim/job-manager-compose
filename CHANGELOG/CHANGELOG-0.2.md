# Changelog 0.2

## [0.2.1](https://github.com/project-cdim/job-manager-compose/compare/v0.2.0...v0.2.1) - 2026-10-09

The changes from v0.2.0 are as follows:

### Breaking Changes

- Changed `compose.yml` to be generated from `compose.yml.template` at installation, with proxy settings taken from the common configuration file (`cdim.env`).

## [0.2.0](https://github.com/project-cdim/job-manager-compose/compare/v0.1.1...v0.2.0) - 2026-03-24

The changes from v0.1.1 are as follows:

### Features

- Fixed to mount the Docker volume job-manager-data on the host to the /home/rundeck/server/data directory in the container
- Fixed to mount the Docker volume job-manager-logs on the host to the /home/rundeck/var/logs directory in the container
- Modified to use an API key when executing the housekeeping API of Alert_manager

### Bug Fixes

- Modified to start job-manager-setup after confirming that Rundeck has started
