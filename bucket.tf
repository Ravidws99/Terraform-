# Create a bucket with website files publicly accessible 

/*resource "aws_s3_bucket" "testwebsite_bucket" {
  bucket = "testwebsite-bucket"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.testwebsite_bucket.id
  key          = "index.html"
  content_type = "text/html"
  source       = "index.html"
}

resource "aws_s3_bucket_object" "error" {
  bucket       = aws_s3_bucket.testwebsite_bucket.id
  key          = "error.html"
  content_type = "text/html"
  source       = "error.html"
}*/
