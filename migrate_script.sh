#!/bin/bash
rm -rf logfile.txt
rm -rf error.log
mkdir -p source
mkdir -p migrated
tmp=$(mktemp)
exec >logfile.txt 2>&1
set -x

while read p
do IFS=, read -r b_name b_aba b_number b_cs_number notes<<< "${p}"
if [ ! -z "$p" -a "$p" != " " ]; then
    if [ ! -f bitrise-appspec-hierarchy-prod/Client/appspec_d1f_prod_${b_number}/properties.json ]; then
        echo "Existing d1f Appspec: appspec_d1f_prod_${b_number} not found;please migrate from 5.0 to 6.0 first and then try running this script">>error.log
    else
        mkdir -p source
        cp -R bitrise-appspec-hierarchy-prod/Client/appspec_d1f_prod_${b_number} source/
        mkdir -p migrated/appspec_d1fbeacon_prod_${b_number}
        cp -R bitrise-appspec-hierarchy-prod/Client/appspec_d1f_prod_${b_number}/* migrated/appspec_d1fbeacon_prod_${b_number}/
        
		echo "Req#1 : replace d1f-auth with beacon-auth" 
		
		index=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq 'map(.lib == "d1f-authentication") | index(true)')
        ./jq "del(.emp_common_feature_list[$index])" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        count1=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        
        ./jq ".emp_common_feature_list[$count1].lib = \"beacon-authentication\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count1].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        
        # Modified script
        ./jq '.emp_common_feature_list += [{"lib": "new-lib", "path": "new_path.json"}]' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json

        
		echo "Req#2 replace emp-splash with beacon-splash"
        
		index=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq 'map(.lib == "emp-splash") | index(true)')
        ./jq "del(.emp_common_feature_list[$index])" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        count2=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count2].lib = \"beacon-splash\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count2].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#3 : Update customer support number"
		if [ ! -z "${b_cs_number}" -a "${b_cs_number}" != " " ]; then
            cs_numb="${b_cs_number//-}"
            ./jq ".beacon_authentication_customer_support = \"${cs_numb}\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        else
            echo "${b_name} : Could not find the Customer Support Phone Number" >>error.log
            ./jq ".beacon_authentication_customer_support = \"\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        fi
        URL_ABA=$(./jq -r '.d1_gateway_beb_endpoint' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json )
        IFS=. env_ABA=(${URL_ABA#*https://b})
        
		echo "Req#4 : Update enrollment url ;remove existing unauthenticated links "
		
		./jq ".beacon_authentication_enrollment_url = \"https://b${env_ABA[0]}.flex.online-banking-services.com/cuFlexEnrollment/?channel=mobile60#!/selfEnrollment/home\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq 'del(.emp_authentication_unauthenticated_links)' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		./jq ".parent_appspec = \"Environment/appspec_d1fbeacon_prod\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        blkimage=$(ls *.svg |grep ${b_number})
        cp "$blkimage" migrated/appspec_d1fbeacon_prod_${b_number}/assets/bcnlogo.svg
        mkdir -p migrated/appspec_d1fbeacon_prod_${b_number}/native/ios/config
        cp migrated/appspec_d1fbeacon_prod_${b_number}/native/assets/ios/Assets.xcassets/Splash.imageset/Default-Universal.png migrated/appspec_d1fbeacon_prod_${b_number}/native/ios/config/bcn_splash.png

        # New Modification (2)
        # Copy final.json under location migrated/appspec_d1fbeacon_prod_${b_number}/assets/resources
        
        if [ ! -f migrated/appspec_d1fbeacon_prod_${b_number}/assets/resources/final.json ]; then
            # If final.json does not exist, copy it
            cp final.json migrated/appspec_d1fbeacon_prod_${b_number}/assets/resources/
        else
            # If final.json exists, overwrite it
            cp final.json migrated/appspec_d1fbeacon_prod_${b_number}/assets/resources/final.json
        fi

        echo "final.json has been copied"

        # replace emp_common_more_menu_legal in final.json from navigation.json
        src_file="migrated/appspec_d1fbeacon_prod_${b_number}/assets/resources/navigation.json"
        dst_file="migrated/appspec_d1fbeacon_prod_${b_number}/assets/resources/final.json"

        src_json=$(cat "$src_file")
        dst_json=$(cat "$dst_file")

        # Extracting from navigation.json
        json_obj=$(echo "$src_json" | ./jq '.moreMenu[] | .items[] | select(.type == "PARENT" and .label == "emp_common_more_menu_legal")')
        echo "Extracted object:"
        echo "$json_obj"

        
        if [ -z "$json_obj" ]; then
            echo "No matching JSON object found for emp_common_more_menu_legal in navigation.json. Skipping to next iteration."
            continue
        fi

        # Replcaing in final.json
        updated_json=$(echo "$dst_json" | ./jq --argjson obj "$json_obj" '
        .moreMenu |= map(
            if .items then
            .items |= map(
                if .type == "PARENT" and .label == "emp_common_more_menu_legal" then $obj else . end
            )
            else
            .
            end
        )')

        echo "$updated_json" > "$dst_file"
        echo "Overwritten in appspec_d1fbeacon_prod_${b_number}"

        
        # src_json=$(cat "$src_file")
        # dst_json=$(cat "$dst_file")

        # # if emp_common_more_menu_external_links exist in navigation.json then pick this section from navigation.json and add to final.json in the end of moreMenu
        json_obj2=$(echo "$src_json" | ./jq '.moreMenu[] | .items[] | select(.type == "PARENT" and .label == "emp_common_more_menu_external_links")')

        # upd_json2=$(echo "$dst_json" | ./jq --argjson obj "$json_obj2" '.moreMenu += [$obj]')
        # echo "$upd_json2" > "$dst_file"

        if [ -z "$json_obj2" ]; then
            echo "No matching JSON object found for emp_common_more_menu_external_links in navigation.json. Skipping to next iteration."
            continue
        fi

        # updated_json2=$(echo "$dst_json" | ./jq --argjson obj "$json_obj2" '
        # .moreMenu |= map(
        #     if .items then
        #     .items += [$obj]
        #     else
        #     .
        #     end
        # )')

        upd_json2=$(echo "$dst_json" | ./jq --argjson obj "$json_obj2" '.moreMenu += [$obj]')
        echo "$upd_json2" > "$dst_file"
        echo "Added emp_common_more_menu_external_links to appspec_d1fbeacon_prod_${b_number}"


    fi
fi
done<mig_list.csv
