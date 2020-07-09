# S3mount
Script bash S3 Mounting to EC2 AWS

This is how to S3 Storage mounting to instance EC2 AWS

it's not that hard but quite tricky. if you go wrong for single step then you might get back to square

go to https://aws.amazon.com/id/console/ then select service S3 Storage then upload your apps folder
Here's step for create name bucket :
1. Create Name Bucket
2. Chose your Region
3. Uncheck block public instead make it public
4. Then finish

Remember! once you create the buckets name you can't create the same name in the future

Here's step for upload your apps :
1. Hit upload button
2. Choose permission and make it write and read
for this step i recomend using new IAM role if you want your colleague can access it as well

then run the script and adjust it with your acces key from your account AWS
