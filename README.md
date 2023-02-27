# Seeker

Seeker is a Bash script that searches for sensitive information on a target system, such as password files or configuration files, and displays the list of files and paths to the user. The script uses the `grep` command to search for regular expressions in specified files and directories.

## Usage

`./seeker.sh [-h] [-p search_path] [-f file_pattern] [-r regex_pattern]` 

### Options

-   `-h`: Show the help message.
-   `-p search_path`: Specify the search path(s). Default: `/etc`, `/home`, `/var`, `/usr/local`.
-   `-f file_pattern`: Specify the file pattern(s) to search. Default: `*.conf`, `*.cfg`, `*.passwd`, `*.password`, `*.key`, `*.txt`.
-   `-r regex_pattern`: Specify the regular expression(s) to search for. Default: `(password|pass|passwd|secret|login)[\s:]+([^\s]+)`.

## Examples

To search for credit card numbers in all `.txt` files in the `/home/user` directory, use the following command:

`./seeker.sh -p /home/user -f "*.txt" -r '\b\d{4}[ -]?\d{4}[ -]?\d{4}[ -]?\d{4}\b'` 

To run the script without specifying a regular expression, use the following command:

`./find_sensitive_info.sh` 

This will use the default regular expression to search for sensitive information.

## Regular Expressions

The script uses regular expressions to search for sensitive information in files. If you want to customize the regular expressions used by the script, you can modify the `-r` option when running the script. Some sample regular expressions that can be used to search for sensitive information are included in the script.

## Contributing

If you find any bugs or have suggestions for how to improve this script, please feel free to submit an issue or pull request on GitHub. Contributions are welcome and appreciated!
