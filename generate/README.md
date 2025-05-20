# Scripts for generating input files

`generate.sh` - Reads a list of paths from `url-list.csv`, retrieves them from
`www-dev-acsf`, and creates `output.csv` containing the path, page body size,
and the MD5 hash of the page body.

 The generated output files may be used as `{project-root}/data-files/url-list.csv`

 - `200.csv` - Returned 200 status.  Includes path, response body size in bytes, and MD5 hash.
 - `30x.csv` - Returned a 300 series status code. Path only.
 - `404.csv` - Returned a 404 status. Path only.
