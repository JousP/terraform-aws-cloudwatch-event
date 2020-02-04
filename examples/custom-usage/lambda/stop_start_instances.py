import boto3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    actions = {
        "start": ec2.start_instances,
        "stop": ec2.stop_instances
    }

    action = event['Action']
    instances = event["InstanceIds"]

    if action in actions:
        
        logger.info("%s EC2 instance: %s", action, str(instances))
        return actions[action](InstanceIds=instances)
    else:
        raise Exception('Unsupported method "{}"'.format(action))

