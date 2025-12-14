def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    item = event['Records'][0]['s3']['object']['key']
    print(bucket, item)
    return bucket, item