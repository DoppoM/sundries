param(
    $cloudProvider = "gcp",
    $instanceName,
    $networkName = "$instanceName-netwark",
    $subnet = "$instanceName-subnet",
    $image = "ubuntu-1604-xenial-v20200129",
    $machineType = "n1-highcpu-8"
)

gcloud compute instances create $instanceName --network $networkName --subnet $subnet --image $image --machine-type $machineType