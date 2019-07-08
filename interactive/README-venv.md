

Python
======

Old Python 3
------------

### Python 3.6

Download and install:
* https://snapshot.debian.org/archive/debian/20190322T085555Z/pool/main/p/python3.6/python3.6-minimal_3.6.8-1_amd64.deb
* https://snapshot.debian.org/archive/debian/20190322T085555Z/pool/main/p/python3.6/python3.6-venv_3.6.8-1_amd64.deb

Maybe this too:
* https://snapshot.debian.org/archive/debian/20190322T085555Z/pool/main/p/python3.6/libpython3.6-stdlib_3.6.8-1_amd64.deb

do not use those:
* https://snapshot.debian.org/archive/debian/20190322T085555Z/pool/main/p/python3.6/libpython3.6_3.6.8-1_amd64.deb
* https://snapshot.debian.org/archive/debian/20190322T085555Z/pool/main/p/python3.6/libpython3.6-dev_3.6.8-1_amd64.deb
* https://snapshot.debian.org/archive/debian/20190322T085555Z/pool/main/p/python3.6/python3.6-dev_3.6.8-1_amd64.deb
* https://snapshot.debian.org/archive/debian/20190322T085555Z/pool/main/p/python3.6/python3.6_3.6.8-1_amd64.deb

Fix distutils package (you have to have installed python3.7 and python-distutils):
```bash
sudo apt install python3.7-minimal python3-venv python3-distutils
sudo mv /usr/lib/python3.6/distutils/ /usr/lib/python3.6/distutils/__distutils
sudo ln -s ../python3.7/distutils/ /usr/lib/python3.6/distutils
```


### Python 3.5

Install Python 3.5
* https://snapshot.debian.org/archive/debian/20180921T154550Z/pool/main/p/python3.5/libpython3.5-minimal_3.5.6-1_amd64.deb
* https://snapshot.debian.org/archive/debian/20180921T154550Z/pool/main/p/python3.5/python3.5-venv_3.5.6-1_amd64.deb
* https://snapshot.debian.org/archive/debian/20180921T154550Z/pool/main/p/python3.5/libpython3.5-stdlib_3.5.6-1_amd64.deb

Maybe this too:
* https://snapshot.debian.org/archive/debian/20180921T154550Z/pool/main/p/python3.5/libpython3.5-dev_3.5.6-1_arm64.deb

You need patch `/usr/lib/python3.5/ensurepip/__init__.py` to get (about 65 line):
```
    # Install the bundled software
    try:
        import pip._internal
        return pip._internal.main(args)
    except ImportError:
        import pip
        return pip.main(args)
```

Just call:

```bash
sudo patch -d /usr/lib/python3.5/ensurepip/ -p1 << EOF
--- ensurepip.origin/__init__.py      2019-07-08 08:28:48.297891156 +0200
+++ ensurepip/__init__.py   2019-07-08 08:29:12.306047868 +0200
@@ -63,8 +63,12 @@
         sys.path = additional_paths + sys.path
 
     # Install the bundled software
-    import pip
-    pip.main(args)
+    try:
+        import pip._internal
+        return pip._internal.main(args)
+    except ImportError:
+        import pip
+        return pip.main(args)
 
 
 def version():
EOF
```

