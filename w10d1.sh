# Write a Bash script to greet the user, prompt them to enter their name, and display a personalized message along with the current date and time.
read -p "Hello user. Please enter your name: " response
new_date=$(date +"%Y-%m-%d")
current_time="$(date +"%T")"
echo "Welcome to my Bash script, $response. The date is $new_date. The time is $current_time"

# HERE IS MY SCRIPT THAT I USE TO AUTOMATE THE DEPLOYMENT OF MY CONTAINER:
# Having to type this out all the time would be a pain

# Containerization
cd ../../../
docker build -t firefly-crawler .
docker tag firefly-crawler us-west1-docker.pkg.dev/firefly-application/firefly/crawler
gcloud auth configure-docker us-west1-docker.pkg.dev
docker push us-west1-docker.pkg.dev/firefly-application/firefly/crawler

# Deployment to Cloud Run
gcloud run deploy firefly-crawler \
  --image us-west1-docker.pkg.dev/firefly-application/firefly/crawler \
  --cpu 2 \
  --memory 4Gi \
  --max-instances 5 \
  --concurrency 15 \
  --timeout 20 

