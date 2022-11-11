#!/usr/bin/bash
pkgdir=/tmp/fontinstaller
pkgs='p7zip-full curl'
install=false
for pkg in $pkgs; do
  status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
  if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
    install=true
    break
  fi
done
if "$install"; then
 echo 'Please Install' "$pkg" 'for your distro'
exit 1

 
fi
mkdir -p $pkgdir
mkdir -p $pkgdir/fontfiles/
cd $pkgdir || exit

curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg
7z x SF-Pro.dmg
cd SFProFonts || exit
7z x 'SF Pro Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $pkgdir/fontfiles
cd ..

curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg
7z x SF-Compact.dmg
cd SFCompactFonts || exit
7z x 'SF Compact Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $pkgdir/fontfiles
cd ..

curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg
7z x SF-Mono.dmg
cd SFMonoFonts || exit
7z x 'SF Mono Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $pkgdir/fontfiles
cd ..

curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Arabic.dmg
7z x SF-Arabic.dmg
cd SFArabicFonts || exit
7z x 'SF Arabic Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $pkgdir/fontfiles
cd ..

curl -O https://devimages-cdn.apple.com/design/resources/download/NY.dmg
7z x NY.dmg
cd NYFonts || exit
7z x 'NY Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $pkgdir/fontfiles
cd ..

sudo mkdir -p /usr/share/fonts/applefonts/
sudo mv $pkgdir/fontfiles/* /usr/share/fonts/applefonts/
sudo rm -rf /tmp/fontinstaller/