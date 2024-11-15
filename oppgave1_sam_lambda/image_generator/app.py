import json
import base64
import boto3
import random
import os

# Set up the AWS clients
bedrock_client = boto3.client("bedrock-runtime", region_name="us-east-1")
s3_client = boto3.client("s3")
model_id = "amazon.titan-image-generator-v1"
bucket_name = os.environ['BUCKET_NAME']
kandidatnummer = os.environ['KANDIDATNUMMER']


def lambda_handler(event, context):

    
    prompt = "Default prompt text"
    
    try:
        request_body = json.loads(event['body'])  # Parses the JSON body of the request
        prompt = request_body.get('prompt', 'Default prompt text')  # Get prompt from request, with a default
    except (json.JSONDecodeError, KeyError):
        return {
            "statusCode": 400,
            "body": json.dumps({
                "message": "Invalid request body",
            }),
        }
    
    image_url = generateAndSaveImage(bucket_name, prompt)
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Successfully saved image, this is the URL",
            "prompt": prompt,
            "image_url": image_url  # Return the image URL,
            
        }),
    }
def generateAndSaveImage(bucket_name, prompt):
    seed = random.randint(0, 2147483647)
    s3_image_path = f"{kandidatnummer}/oppgave1/titan_{seed}.png"

    native_request = {
        "taskType": "TEXT_IMAGE",
        "textToImageParams": {"text": prompt},
        "imageGenerationConfig": {
            "numberOfImages": 1,
            "quality": "standard",
            "cfgScale": 8.0,
            "height": 1024,
            "width": 1024,
            "seed": seed,
        }
    }

    response = bedrock_client.invoke_model(modelId=model_id, body=json.dumps(native_request))
    model_response = json.loads(response["body"].read())

    # Extract and decode the Base64 image data
    base64_image_data = model_response["images"][0]
    image_data = base64.b64decode(base64_image_data)

    # Upload the decoded image data to S3
    s3_client.put_object(Bucket=bucket_name, Key=s3_image_path, Body=image_data)

    # Construct the S3 URL
    region = "s3-eu-west-1"  # Replace with your bucket's region if different
    image_url = f"https://{bucket_name}.{region}.amazonaws.com/{s3_image_path}"

    return image_url