terraform {
    backend "s3" {
        region  = "us-east-1"
        bucket  = "elife-data-hub-infrastructure"
        key     = "data-hub.tfstate"
    }
}
