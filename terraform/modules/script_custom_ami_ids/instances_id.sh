#!/bin/bash

region="eu-west-2"
output_directory="../../../custom_ami"

instances=("service_lighting" "service_heating" "status" "auth")
for instance_name in "${instances[@]}"; do
    instance_ids=$(aws ec2 describe-instances \
        --region $region \
        --filters "Name=tag:Name,Values=$instance_name" \
        --query "Reservations[*].Instances[*].InstanceId" \
        --output text)
    
    if [ -n "$instance_ids" ]; then
        file="${output_directory}/${instance_name}.json"
        if [ -f "$file" ]; then
            rm "$file"
        fi
        touch "$file"
        for id in $instance_ids; do
            echo "{ \"instance_id\": \"$id\" }" > "$file"
            break  
        done
    fi
done


