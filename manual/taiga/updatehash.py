"""
Computes the new hash from the remote Taiga setup file and inserts it into the Chocolatey install script
"""
import os, hashlib, urllib.request, re, optparse

def get_remote_sha256_sum(url, max_file_size=100*1024*1024):
    """
    compute remote file hash
    by brianewing https://gist.github.com/brianewing/994303
    """
    remote = urllib.request.urlopen(url)
    hash = hashlib.sha256()

    total_read = 0
    while True:
        data = remote.read(4096)
        total_read += 4096

        if not data or total_read > max_file_size:
            break

        hash.update(data)

    return hash.hexdigest()

def replace_sha256_hash_in_installation_script(filename, new_hash):
    with open(filename, 'r+') as f:
        content = f.read()
        f.seek(0)
        new = re.sub(r'checksum(\s*)=(\s*)([\'\"])([a-f0-9]{,64})\3', r'checksum\1=\2\g<3>' + str(new_hash) + r'\3', content, flags=re.M)
        f.write(new)
        f.truncate()

if __name__ == '__main__':
    opt = optparse.OptionParser()
    opt.add_option('--filename', '-f', default='./tools/chocolateyinstall.ps1')
    options, args = opt.parse_args()
    print('Computing hash')
    sha256 = get_remote_sha256_sum('https://taiga.moe/update/TaigaSetup.exe')
    replace_sha256_hash_in_installation_script(options.filename, sha256)
    print('New hash saved: ' + sha256)