#fastdfs example

from fdfs_client.client import Fdfs_client, get_tracker_conf
tracker_path = get_tracker_conf()
client = Fdfs_client(tracker_path)
ret = client.upload_by_filename('/home/arvin1995/Desktop/pycharm.png')