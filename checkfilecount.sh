var=$(ls /path | wc -l)
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
if [ $var -gt 3 ]; then
tar -cvf /path/file.tar /path/*
rm -rf /path/*
fi
