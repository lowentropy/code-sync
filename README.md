code-sync
=========

Continuously synchronize local code to remote server

Installing
----------

Clone the repo and install gems:

    git clone https://github.com/lowentropy/code-sync
    cd code-sync
    bundle install

Usage
-----

Call sync.rb, passing in the local and remote paths to synchronize.
The remote path uses SSH and must look like `'[user@]host:path'`

Relative paths and symbolic links will be expanded on both sides.

    ruby sync.rb local_path host:remote_path
