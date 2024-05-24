# GitHub Actions for Okteto

## Automate your development workflows using Github Actions and Okteto
GitHub Actions gives you the flexibility to build automated software development workflows. With GitHub Actions for Okteto you can create workflows to build, deploy and update your applications in [Okteto](https://okteto.com).

Try Okteto for free for 30 days, no credit card required. [Start your 30-day trial now](https://www.okteto.com/free-trial/)!

## Github Action for Okteto

With the Okteto Context action you can automate your workflow to configure your Okteto context using an API token. This action is a prerequisite for the rest of the [Okteto actions](https://github.com/okteto/actions).

## Configure your Okteto API Token

Copy [your Okteto API token](https://www.okteto.com/docs/cloud/personal-access-tokens/) and save it [as a secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) with the name `OKTETO_TOKEN` in the GitHub repository.

## Inputs

### `token`

**Required** Your Okteto API token.

### `url`

**Required** Your Okteto instance URL.

### `log-level`

Log level used. Supported values are: `debug`, `info`, `warn`, `error`. (defaults to warn)


## Example usage

This example runs the context action and then activates a namespace.

```yaml
# File: .github/workflows/workflow.yml
on: [push]

name: example

jobs:

  devflow:
    runs-on: ubuntu-latest
    steps:
    
    - uses: okteto/context@latest
      with:
        url: https://okteto.example.com
        token: ${{ secrets.OKTETO_TOKEN }}
    
    - name: "Build"
      uses: okteto/build@latest
```

## Advanced usage

### Custom Certification Authorities or Self-signed certificates

You can specify a custom certificate authority or a self-signed certificate by setting the `OKTETO_CA_CERT` environment variable. When this variable is set, the action will install the certificate in the container, and then execute the action. 

Use this option if you're using a private Certificate Authority or a self-signed certificate in your [Okteto SH](https://www.okteto.com/docs/self-hosted/) instance.  We recommend that you store the certificate as an [encrypted secret](https://docs.github.com/en/actions/reference/encrypted-secrets), and that you define the environment variable for the entire job, instead of doing it on every step.


```yaml
# File: .github/workflows/workflow.yml
on: [push]

name: example

jobs:
  devflow:
    runs-on: ubuntu-latest
    env:
      OKTETO_CA_CERT: ${{ secrets.OKTETO_CA_CERT }}
    steps:
    
    - uses: okteto/context@latest
      with:
        url: https://okteto.example.com
        token: ${{ secrets.OKTETO_TOKEN }}
    
    - name: "Build"
      uses: okteto/build@latest
```
