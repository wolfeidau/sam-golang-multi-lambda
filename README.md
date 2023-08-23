# sam-golang-multi-lambda

This is a sample project that shows how to build and deploy a AWS Lambda function using the SAM CLI that contains multiple functions defined in a single Golang project.

The aim is to illustrate some of the more advanced features of the SAM CLI like building and deploying multiple Go based lambda functions from a single module.

This is a follow up from my blog post https://www.wolfe.id.au/2023/08/09/rip-aws-go-lambda-runtime/ where I discussed how AWS is deprecating the Go Lambda Runtime in favor of the generic `provided.al2` runtime.

# Outline

Some things to note about this project:

1. The project is a single Go module that contains multiple Lambda function binaries, shared code can be stored in `/pkg` or `/internal` and imported by any of the functions.
2. The [Makefile](Makefile) contains custom build flags to ensure a version is provided to each, as well as `ldflags` and the flag to remove the RPC endpoint from the binaries.
3. There is a [template.yaml](template.yaml) that defines the AWS Serverless Application Model (SAM) resources for each function individually.

++Note:++ I have used the `AWS::Serverless::Function` resource `Metadata` to specify the function `BuildMethod` as `go1.x` to ensure each is built and packaged separately. This is mentioned in the migration blog post titled [Migrating AWS Lambda functions from the Go1.x runtime to the custom runtime on Amazon Linux 2](https://aws.amazon.com/blogs/compute/migrating-aws-lambda-functions-from-the-go1-x-runtime-to-the-custom-runtime-on-amazon-linux-2/).

The layout of the project is as follows:

```bash
.
├── Makefile
├── README.md
├── cmd
│   ├── api-lambda
│   │   ├── main.go
│   │   └── main_test.go
│   └── scheduled-lambda
│       ├── main.go
│       └── main_test.go
├── events
│   └── event.json
├── go.mod
├── go.sum
├── samconfig.toml
└── template.yaml
```

## Requirements

* AWS CLI already configured with Administrator permission
* [Golang](https://golang.org)
* SAM CLI - [Install the SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)

### Installing dependencies & building the target 

In this example we use the built-in `sam build` to automatically download all the dependencies and package our build target.   
Read more about [SAM Build here](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-build.html) 

The `sam build` command is wrapped inside of the `Makefile`. To execute this simply run
 
```shell
make
```

# License

This project is released under Apache 2.0 license and is copyright [Mark Wolfe](https://www.wolfe.id.au).