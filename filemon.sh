var=$(ls /opt/lsy/netline/schedops/import/ssim/incoming | wc -l)
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
if [ $var -gt 3 ]; then
tar -cvf /home/netline/backup/$current_time.tar /opt/lsy/netline/schedops/import/ssim/incoming/*
rm -rf /opt/lsy/netline/schedops/import/ssim/incoming/*
fi
