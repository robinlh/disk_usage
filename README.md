# disk_usage
Some simple scripts to get the last modified dates of user folders and the volume of disk space that hasn't been changed.

### `get_last_modified.sh`
Very simple bash script to get the last modified date of a folder using `getfattr` and `ceph.rctime`. Takes two arguments - the folder in which to get the usage information from and thedesired path to put the output text file in. Must be run as `sudo`.
```
sudo ./get_last_modified.sh /path/to/user_folder /path/to/example.txt
> last disk usage stats for folder /user_folder/ created at /path/to/example.txt
```
### `scratch_usage.ipynb`
Basic wrangling of csv file to get more information about users with large volumes of unchanged data. See notebook for example usage with `example.txt`.
