# Front Desk Readme

## Deployment and Environments

Make sure you have the Elastic Beanstalk CLI installed.

### Staging/Deployment

    $ ./deploy.sh staging

### Staging/Production console access

    $ eb ssh staging
    (enter ssh keyphrase)
    $ cd /var/app/current
    $ bundle exec rails c
