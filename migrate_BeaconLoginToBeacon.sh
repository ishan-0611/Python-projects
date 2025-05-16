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
    if [ ! -f bitrise-appspec-hierarchy-prod/Client/appspec_d1fbeacon_prod_${b_number}/properties.json ]; then
        echo "Existing d1f Appspec: appspec_d1fbeacon_prod_${b_number} not found;please migrate from Beacon 1.0 to Beacon 2.0 first and then try running this script">>error.log
    else
        mkdir -p source
        cp -R bitrise-appspec-hierarchy-prod/Client/appspec_d1fbeacon_prod_${b_number} source/
        mkdir -p migrated/appspec_d1fbeacon_prod_${b_number}
        cp -R bitrise-appspec-hierarchy-prod/Client/appspec_d1fbeacon_prod_${b_number}/* migrated/appspec_d1fbeacon_prod_${b_number}/
        
		echo "Req#1 : replace d1f-mainlanding with beacon-mainlanding" 
		
		index=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq 'map(.lib == "d1f-mainlanding") | index(true)')
        ./jq "del(.emp_common_feature_list[$index])" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        count1=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        
        ./jq ".emp_common_feature_list[$count1].lib = \"beacon-mainlanding\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count1].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        
		echo "Req#2 Add beacon-billpay"
        
		count2=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count2].lib = \"beacon-billpay\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count2].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#3 Add beacon-profile"
        
		count3=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count3].lib = \"beacon-profile\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count3].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#4 Add beacon-contactus"
        
		count4=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count4].lib = \"beacon-contactus\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count4].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#5 Replace d1f-account with beacon-account"
		index=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq 'map(.lib == "d1f-account") | index(true)')
        ./jq "del(.emp_common_feature_list[$index])" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        
		count5=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count5].lib = \"beacon-account\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count5].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#6 Replace d1f-credit-insights with beacon-credit-insights"
		index=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq 'map(.lib == "d1f-credit-insights") | index(true)')
        ./jq "del(.emp_common_feature_list[$index])" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        
		count6=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count6].lib = \"beacon-credit-insights\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count6].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#7 Replace d1f-personalfinance with beacon-personalfinance"
		index=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq 'map(.lib == "d1f-personalfinance") | index(true)')
        ./jq "del(.emp_common_feature_list[$index])" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        
		count7=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count7].lib = \"beacon-personalfinance\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count7].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#8 Add beacon-contactus"
        
		count8=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count8].lib = \"beacon-docs\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count8].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#9 Add beacon-approval"
        
		count9=$(./jq '.emp_common_feature_list' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json | ./jq  length)
        ./jq ".emp_common_feature_list[$count9].lib = \"beacon-approval\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq ".emp_common_feature_list[$count9].path = \"d1f_prod_versions.json\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		
		echo "Req#10 : Update customer support number"
		if [ ! -z "${b_cs_number}" -a "${b_cs_number}" != " " ]; then
            cs_numb="${b_cs_number//-}"
            ./jq ".beacon_authentication_customer_support = \"${cs_numb}\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        else
            echo "${b_name} : Could not find the Customer Support Phone Number" >>error.log
            ./jq ".beacon_authentication_customer_support = \"\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        fi
        URL_ABA=$(./jq -r '.d1_gateway_beb_endpoint' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json )
        IFS=. env_ABA=(${URL_ABA#*https://b})
        
		echo "Req#8 : Update enrollment url ;remove existing unauthenticated links "
		
		./jq ".beacon_authentication_enrollment_url = \"https://b${env_ABA[0]}.flex.online-banking-services.com/cuFlexEnrollment/?channel=mobile60#!/selfEnrollment/home\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
        ./jq 'del(.emp_digitalmarketing_bank_ficode)' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		./jq 'del(.emp_digitalmarketing_bank_static_heroimage_entitlement)' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		./jq 'del(.emp_digitalmarketing_bank_dmp_heroimage_entitlement)' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		./jq 'del(.emp_digitalmarketing_bank_mpromote_entitlement)' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		./jq 'del(.emp_router_variant)' migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json
		echo "Req#4 : Update parent_appspec "
		./jq ".parent_appspec = \"Client/appspec_d1fbeacon_hsn_pilot\"" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json > "$tmp" && mv "$tmp" migrated/appspec_d1fbeacon_prod_${b_number}/properties.json


        # Copy final.json under bitrise-appspec-hierarchy-prod/appspec_d1fbeacon_prod_${b_number}/assets/resources
        if [ ! -f bitrise-appspec-hierarchy-prod/appspec_d1fbeacon_prod_${b_number}/assets/resources/final.json ]; then
            # If final.json does not exist, copy it
            cp final.json bitrise-appspec-hierarchy-prod/Client/appspec_d1fbeacon_prod_${b_number}/assets/resources/
        else
            # If final.json exists, overwrite it
            cp final.json bitrise-appspec-hierarchy-prod/Client/appspec_d1fbeacon_prod_${b_number}/assets/resources/final.json
        fi

        echo "final.json has been copied"

        
        # Replace emp_common_more_menu_legal in final.json from navigation.json
        src_file="C:/Users/e5750507/Documents/beacon2.0/beacon-migration/bitrise-appspec-hierarchy-prod/Client/appspec_d1fbeacon_prod_${b_number}/assets/resources/navigation.json"
        dst_file="C:/Users/e5750507/Documents/beacon2.0/beacon-migration/bitrise-appspec-hierarchy-prod/Client/appspec_d1fbeacon_prod_${b_number}/assets/resources/final.json"

        src_json=$(cat "$src_file")
        dst_json=$(cat "$dst_file")

        # Extracting emp_common_more_menu_legal object from navigation.json
        json_obj=$(echo "$src_json" | ./jq '.moreMenu[] | .items[] | select(.type == "PARENT" and .label == "emp_common_more_menu_legal")')
        echo "Extracted object:"
        echo "$json_obj"

        
        if [ -z "$json_obj" ]; then
            echo "No matching JSON object found for emp_common_more_menu_legal in navigation.json. Skipping to next iteration."
            continue
        fi

        # Replacing in final.json
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

        
        # Extracting emp_common_more_menu_external_links object fron navigation.json
        json_obj2=$(echo "$src_json" | ./jq '.moreMenu[] | .items[] | select(.type == "PARENT" and .label == "emp_common_more_menu_external_links")')

        echo "Object:"
        echo "$json_obj2"

        if [ -z "$json_obj2" ]; then
            echo "No matching JSON object found for emp_common_more_menu_external_links in navigation.json. Skipping to next iteration."
            continue
        fi

        upd_json2=$(echo "$dst_json" | ./jq --argjson obj "$json_obj2" '
        .moreMenu |= map(
            if .items then
            .items += [$obj]
            else
            .
            end
        )')

        # Adding object to final.json
        echo "$upd_json2" > "$dst_file"
        echo "Object added to Final.json"


        # Checking objects (PRESENT -> final.json) + (NOT PRESENT -> navigation.json)
        ./jq --slurp '.[1].bottomNav - .[0].bottomNav' "$src_file" "$dst_file" > bnv_not_in_nav.json
        ./jq --slurp '.[1].moreMenu - .[0].moreMenu' "$src_file" "$dst_file" > mm_not_in_nav.json

        # Checking objects (PRESENT -> navigation.json) + (NOT PRESENT -> final.json)
        ./jq --slurp '.[0].bottomNav - .[1].bottomNav' "$src_file" "$dst_file" > bnv_not_in_final.json
        ./jq --slurp '.[0].moreMenu - .[1].moreMenu' "$src_file" "$dst_file" > mm_not_in_final.json

        # Extracting paths which are NOT PRESENT in final.json
        op_file = "output.txt"

        # Selecting all paths from navigation.json
        ./jq -r '.. | objects | select(has("path")) | .path' "$src_file" | sort -u > nav_paths.txt

        # Selecting all paths from final.json
        ./jq -r '.. | objects | select(has("path")) | .path' "$dst_file" | sort -u > final_paths.txt

        # Comparison logic
        # > "$op_file"
        # echo "$b_number" >> "$op_file"
        # ech0 "-----------------------------" >> "$op_file"
        # while IFS= read -r nav_path; do
        # if ! grep -q "^$nav_path" final_paths.txt; then
        #     echo "$nav_path" >> "$op_file"
        # fi
        # done < nav_paths.txt

        
        # > "$op_file"
        # while IFS= read -r nav_path; do
        #     match=$(./jq -r --arg nav "$nav_path" '
        #     .. | objects | select(has("path")) | .path | select(startswith($nav))' "$dst_file")

        #     if [ -z "$match" ]; then
        #      echo "$nav_path" >> "$op_file"
        #     fi
        # done < nav_paths.txt
        
        # echo "b_number : $b_number" >> "$op_file"
        # echo "------------------------------------" >> "$op_file"
        # comm -2 -3 nav_paths.txt final_paths.txt >> "$op_file"

        {
            echo "b_number : $b_number"
            echo "------------------------------------"
            comm -23 nav_paths.txt final_paths.txt
            echo
        } >> "$op_file"

    fi
fi
done<mig_list_beacon_2_0.csv
