#!/bin/sh
#  Shimaki Matsubara <shimaki@bb.mbn.or.jp> 1998/09/16
#                            Last modified: 1999/08/06
#
# autoconf/automake/gettext ��ưȽ�� autogen.sh 
#
# �Х�
#   1�ĤΥѥå��������ʣ���� configure.in ���ޤޤ���Τˤ�
#   �б����Ƥ��ޤ���
#
#   �Ť��С������� gettext �ѤΥѥå������ˤ��б����Ƥ��ޤ���
#   gettext 0.10.35 �ʹߤ�˾�ޤ����Ǥ���
#============================================================
# conf_flags �ѿ�
#   configure ������ץȤ��Ϥ�������ȯ�ѤΥե饰����ꤷ�ޤ���
#   ��:
#     --enable-maintainer-mode
#     --enable-compile-warnings
#     --enable-debug=yes
conf_flags=

# configure.in ��̵����лϤޤ�ޤ���
(test -f configure.in) || 
{
  #echo "**Error**: You must write 'configure.in', first."
  echo "**���顼**: �ǽ�� 'configure.in' ��������Ƥ���������"
  exit 1
}

FILE=`sed 's/^.*AC_INIT.*(\(.*\)).*$/\1/;t;d' configure.in`
PACKAGE=`sed 's/^.*PACKAGE=\(.*\)$/\1/;t;d' configure.in`
# gettext ����Ѥ��뤫Ƚ�̤��ޤ���
ALL_LINGUAS=`sed 's/^.*ALL_LINGUAS="\?\([^"]*\)"\?$/\1/;t;d' configure.in`
# automake ����Ѥ��뤫Ƚ�̤��ޤ���
(test -f Makefile.am) && { ENABLE_AUTOMAKE=yes; }
# aclocal �Ѥ� include �ǥ��쥯�ȥ꤬���ꤵ��Ƥ��뤫Ĵ�٤ޤ���
MACRODIRS=`sed 's/^.*AM_ACLOCAL_INCLUDE(\(.*\)).*$/\1/;t;d' configure.in`
DIE=0

# AC_INIT ��ɬ�ܤǤ���
(test -f $FILE) ||
{
  #echo "**Error**: You must run this script in the top-level '$PACKAGE' directory"
  echo "**���顼**: '$PACKAGE' �ȥåץǥ��쥯�ȥ�Ǥ��Υ�����ץȤ�¹Ԥ��Ƥ���������"
  exit 1
}

# automake �Ǥϡ�PACKAGE ̾��ɬ�ܤǤ���
(test "$ENABLE_AUTOMAKE" = "yes") && (test -z "$PACKAGE") && 
{
  PACKAGE=`sed 's/^.*AM_INIT_AUTOMAKE.*(\([^,]*\),[^)]*).*$/\1/;t;d' configure.in`
  (test -z "$PACKAGE") &&
  {
    #echo "**Error**: You must set PACKAGE variable to your package name in configure.in"
    echo "**���顼**: 'configure.in' ��� PACKAGE �ѿ��򤢤ʤ��Υѥå�����̾��������Ƥ��������� "
    exit 1
  }
}


# autoconf �����󥹥ȡ��뤵��Ƥ��뤫Ĵ�٤ޤ���
(autoconf --version) < /dev/null > /dev/null 2>&1 ||
{
  #echo
  #echo "**Error**: You must have autoconf installed to compile '$PACKAGE'."
  #echo "Download the appropriate package for your distribution,"
  #echo "or get the source at ftp://ftp.gnu.org/pub/gnu/"
  echo
  echo "**���顼**: '$PACKAGE' �򥳥�ѥ��뤹�뤿��ˤ� autoconf �򥤥󥹥ȡ��뤹��ɬ�פ�����ޤ���"
  echo "            ���ʤ��Υǥ����ȥ�ӥ塼������Ѥ� autoconf �򥤥󥹥ȡ��뤹�뤫"
  echo "            ftp://ftp.gnu.org/pub/gnu/ ���饽���������ꡢ����ѥ��뤷�Ƥ���������"
  echo "        ��: (Debian GNU/Linux �桼����)"
  echo "            $ apt-get -fy install autoconf"
  DIE=1
}
# automake �����󥹥ȡ��뤵��Ƥ��뤫Ĵ�٤ޤ���
(test "$ENABLE_AUTOMAKE" = "yes") &&
{
  (automake --version) < /dev/null > /dev/null 2>&1 ||
  {
    #echo
    #echo "**Error**: You must have automake installed to compile '$PACKAGE'."
    #echo "Download the appropriate package for your distribution,"
    #echo "or get the source at ftp://ftp.gnu.org/pub/gnu/"
  echo
  echo "**���顼**: '$PACKAGE' �򥳥�ѥ��뤹�뤿��ˤ� automake �򥤥󥹥ȡ��뤹��ɬ�פ�����ޤ���"
    echo "          ���ʤ��Υǥ����ȥ�ӥ塼������Ѥ� automake �򥤥󥹥ȡ��뤹�뤫"
    echo "          ftp://ftp.gnu.org/pub/gnu/ ���饽���������ꡢ����ѥ��뤷�Ƥ���������"
    echo "      ��: (Debian GNU/Linux �桼����)"
    echo "          $ apt-get -fy install automake"
    DIE=1
  }
}
# gettext �����󥹥ȡ��뤵��Ƥ��뤫Ĵ�٤ޤ���
(grep "^AM_GNU_GETTEXT" configure.in > /dev/null) &&
{
  (gettext --version) < /dev/null > /dev/null 2>&1 ||
  {
    #echo
    #echo "**Error**: You must have gettext installed to compile '$PACKAGE'."
    #echo "           Download the appropriate package for your distribution,"
    #echo "           or get the source at ftp://ftp.gnu.org/pub/gnu/"
    echo
    echo "**���顼**: '$PACKAGE' �򥳥�ѥ��뤹�뤿��ˤ� gettext �򥤥󥹥ȡ��뤹��ɬ�פ�����ޤ���"
    echo "            ���ʤ��Υǥ����ȥ�ӥ塼������Ѥ� gettext �򥤥󥹥ȡ��뤹�뤫"
    echo "            ftp://ftp.gnu.org/pub/gnu/ ���饽���������ꡢ����ѥ��뤷�Ƥ���������"
    echo "        ��: (Debian GNU/Linux �桼����)"
    echo "            $ apt-get -fy install gettext"
    DIE=1
  }
}
(grep "^AM_GNOME_GETTEXT" configure.in > /dev/null) &&
{
  (gettext --version) < /dev/null > /dev/null 2>&1 ||
  {
    #echo
    #echo "**Error**: You must have gettext installed to compile '$PACKAGE'."
    #echo "           Download the appropriate package for your distribution,"
    #echo "           or get the source at ftp://ftp.gnu.org/pub/gnu/"
    echo
    echo "**���顼**: '$PACKAGE' �򥳥�ѥ��뤹�뤿��ˤ� gettext �򥤥󥹥ȡ��뤹��ɬ�פ�����ޤ���"
    echo "            ���ʤ��Υǥ����ȥ�ӥ塼������Ѥ� gettext �򥤥󥹥ȡ��뤹�뤫"
    echo "            ftp://ftp.gnu.org/pub/gnu/ ���饽���������ꡢ����ѥ��뤷�Ƥ���������"
    echo "        ��: (Debian GNU/Linux �桼����)"
    echo "            $ apt-get -fy install gettext"
    DIE=1
  }
}

# libtool �����󥹥ȡ��뤵��Ƥ��뤫Ĵ�٤ޤ���
(grep "^AM_PROG_LIBTOOL" configure.in > /dev/null) &&
{
  (libtool --version) < /dev/null > /dev/null 2>&1 ||
  {
    #echo
    #echo "**Error**: You must have libtool installed to compile '$PACKAGE'."
    #echo "Download the appropriate package for your distribution,"
    #echo "or get the source at ftp://ftp.gnu.org/pub/gnu/"
    echo
    echo "**���顼**: '$PACKAGE' �򥳥�ѥ��뤹�뤿��ˤ� libtool �򥤥󥹥ȡ��뤹��ɬ�פ�����ޤ���"
    echo "            ���ʤ��Υǥ����ȥ�ӥ塼������Ѥ� libtool �򥤥󥹥ȡ��뤹�뤫"
    echo "            ftp://ftp.gnu.org/pub/gnu/ ���饽���������ꡢ����ѥ��뤷�Ƥ���������"
    echo "        ��: (Debian GNU/Linux �桼����)"
    echo "            $ apt-get -fy install libtool"
    DIE=1
  }
}

(test "$DIE" -eq 1) && exit 1

(test -z "$*") &&
{
    #echo "**Warning**: I am going to run ./configure with no arguments."
    #echo "             if you wish to pass any to it, please specify them on the "
    #echo "             '$0' command line."
    echo "**�ٹ�**: ./configure �����̵���Ǽ¹Ԥ��ޤ���"
    echo "          �⤷��������ꤷ�����ΤǤ���С�"
    echo "          '$0' �ΰ����˻��ꤷ�Ƥ���������"
}

#echo processing...
echo ������...

# ��¸�ط��򵭽Ҥ����ǥ��쥯�ȥ꤬����Ȥ��Ϻ�����롣
files=`find -name .deps`
#echo "Cleaning .deps/ directories ..."
echo "�����... .deps/ �ǥ��쥯�ȥ� ..."
for d in $files; do
  echo -n "   $d"
  if test -d $d; then
    if (rm -r $d); then
      #echo "...removed...OK"
      echo "...���...��λ"
    else
      #echo "...failed to remove...Why..."
      echo "...���...����...�ʤ�..."
    fi
  else
    #echo "...not found...Why..."
    echo "...�������ޤ���...�ʤ�..."
  fi
done

# automake ��ɬ�פʥե����뤬̵�����Ϥ���� automake �������롣
#
# NEWS README AUTHORS ChangeLog �Τɤ�⸫�Ĥ���ʤ����ϡ�
# --foreign �� automake ���Ϥ���
#
requires="NEWS README AUTHORS ChangeLog"
#echo -n "Checking document files ..."
echo -n "��ǧ��... �ɥ�����ȥե����� ..."
req_flag=0
for f in $requires; do
  test -f $f && test -s $f && req_flag=1
done

if test "$req_flag" -eq 1 ; then
  echo ""
  for f in $requires; do
    if test ! -f $f; then
      #echo "Creating $f..."
      echo "������... $f..."
      touch $f
    elif test ! -s $f; then
      #echo "Checking $f ...empty...should be written...OK?"
      echo "��ǧ��... $f... ���Ǥ���ɬ����Ȥ�������Ƥ�������"
    else
      #echo "Checking $f ...OK"
      echo "��ǧ��... $f...��λ"
    fi
  done
else
  #echo " skiped"
  echo " ���������Ф��ޤ�"
  automake_flags="--foreign"
fi

# gettext �Ѥγ�ĥ��ʬ
# ɬ�פ� .po �ե����������å����ޤ���
# po/POTFILES.in �����Ĥ���ʤ���Х���ץ��������ޤ���
(test -n "$ALL_LINGUAS") &&
{
  ((test -d po) && (test -d intl)) || 
  {
    (test -r aclocal.m4) ||
    {
      #echo "Creating aclocal.m4 ..."
      echo "������... aclocal.m4 ..."
      touch aclocal.m4
    }
    #echo "Running gettextize..."    
    echo "�¹���... gettextize..."    
    echo "no" | gettextize --force --copy
    (test -r aclocal.m4) && chmod u+w aclocal.m4
  }

  #echo "Checking po files ..."
  echo "��ǧ��... po �ե����� ..."
  for l in $ALL_LINGUAS; do
    po=po/$l.po
    if test ! -f $po; then
      #echo "Creating $po ..."
      echo "������... $po ..."
      touch $po
    else
      #echo "Checking $po ...OK"
      echo "��ǧ��... $po ...��λ"
    fi
  done

  # po/POTFILES.in �Υ���ץ��������ޤ���
  (test ! -f po/POTFILES.in) && 
  {
    rm -f po/POTFILES.in.example
     # �������ե�����餷����*.c �ե������������󤷤ޤ���
    # intl/, po/ �ǥ��쥯�ȥ���Υ������Ͻ���ޤ���
    src=`find -type f -name '*.c' | sed '/\/intl\//d; /\/po\//d'`
    # �������ե�������椫�� "_(" �򸡺����ޤ���
    # ����ʸ���󤬤����...
    for f in $src; do
      (grep \_\( $f > /dev/null 2>&1) && echo $f >> po/POTFILES.in.example
    done
    # po/POTFILES.in.example ����������ʤ��ä��Ȥ��ϡ�
    # ���Υե������������ޤ���
    if test ! -f po/POTFILES.in.example; then
      touch po/POTFILES.in.example
    fi
    cp po/POTFILES.in.example po/POTFILES.in
    #echo "**Warning**: po/POTFILES.in was generated automaticaly."
    echo "**�ٹ�**: po/POTFILES.in ��ưŪ�˺������ޤ�����"
  }
}

# /usr/share/aclocal �� /usr/local/share/aclocal ��¸�ߤ���Ȥ��ϡ�
# ���ˤĤ��Ĥޤ򤢤碌�ޤ���
(test "$ENABLE_AUTOMAKE" = "yes") && 
  (test -d /usr/share/aclocal) && 
  (test -d /usr/local/share/aclocal) &&
{
  # �ǥ��쥯�ȥ�̾�Ϥ����ǻ��ꤷ�Ƥ��ޤ���
  macros=m4

  # aclocal �� path ��Ĵ�١�.m4 ��ɤ������ɤफĴ�٤ޤ���
  if test -f /usr/local/bin/aclocal; then
    acl_path1=/usr/local/share/aclocal
    acl_path2=/usr/share/aclocal
  elif test -f /usr/bin/aclocal; then
    acl_path1=/usr/share/aclocal
    acl_path2=/usr/local/share/aclocal
  fi

  (test -n "$acl_path1") &&
  {
    # ¾���Υǥ��쥯�ȥ�ˤ����ʤ� .m4 ���ɤߤ��ޤ�ʤ��Τǡ�
    # $macros/ ��������������إ��ԡ����ޤ���
    echo ""

    MACRODIRS="$MACRODIRS $macros"
    pwd=`pwd`
    cd $acl_path2
    files=`find -type f -name '*.m4'`
    # aclocal �������å����ʤ� .m4 ���ɤߤ���褦�ˤ��ޤ���
    for f in $files; do
      # Ʊ���ե�����̾�� $acl_path1 �ˤ���С�����Ͼ��ͤ���Τ�
      # ���Ф��ޤ���
      ff=$acl_path1/$f
      if test ! -f $ff; then
        # $f �ϡ�aclocal ���ɤߤ��ޤ�ʤ� .m4 �Ǥ���
	# �桼�������ꤹ�� $MACRODIRS ����ˤ��뤫�ɤ���Ĵ�٤ޤ���
	FLAG=0
	for d in $MACRODIRS; do
	  if test -f $pwd/$d/`basename $f`; then
	    FLAG=1
	    break
	  fi
	done
	if test $FLAG -eq 0; then
	  # $MACRODIRS ����ˤ⸫�Ĥ���ʤ��ä��Τǥ��ԡ����ޤ���
	  mkdir $pwd/$macros > /dev/null 2>&1
          cp $f $pwd/$macros
          #echo "  " `basename $f` " ... imported from $acl_path2"
          echo "  " `basename $f` " ... $acl_path2 ��������ߤޤ���"
	else
	  #echo "  " `basename $f` " ... already imported"
	  echo "  " `basename $f` " ... ���˼����ޤ�Ƥ��ޤ�"
	fi
      fi
    done
    cd $pwd
  }
}

if grep "^AM_PROG_LIBTOOL" configure.in > /dev/null; then
  #echo "Running libtoolize..."
  echo "�¹���... libtoolize..."
  libtoolize --force --copy
fi

# ���������衢configure script �ޤǤϡ�
# ���ޥ�ɤ�1�ĤǤ⼺�Ԥ�����ߤޤ�ޤ���
#
# acinclude.m4 ���ɤ߹��ߡ�aclocal.m4 ��������롣
if test "$ENABLE_AUTOMAKE" = "yes"; then
  # aclocal �˰�������ꤷ���ɤߤ��ޤ��ޤ���
  for d in $MACRODIRS; do
    if test -d $d; then
      aclocal_include="$aclocal_include -I $d"
    fi
  done

  # GNOME_INIT ������Ȥ��ϡ�gnome �Ѥ� m4 ���ɤߤ���
  (grep "^GNOME_INIT" configure.in > /dev/null) &&
  {
    (echo $ACLOCAL_FLAGS | grep "gnome" > /dev/null) ||
    (echo $aclocal_include | grep "gnome" > /dev/null) || 
    aclocal_include="$aclocal_include -I $acl_path1/gnome"
  }

  #echo "Running aclocal $ACLOCAL_FLAGS $aclocal_include..." &&
  echo "�¹���... aclocal $ACLOCAL_FLAGS $aclocal_include..." &&
  aclocal $ACLOCAL_FLAGS $aclocal_include
fi &&
# configure.in ���ɤ߹��ߡ�configure ��������롣
#echo "Running autoconf..." &&
echo "�¹���... autoconf..." &&
autoconf &&
# acconfig.h ���ɤ߹��ߡ�config.h.in ��������롣
if grep "^AM_CONFIG_HEADER" configure.in > /dev/null; then
  #echo "Running autoheader..." &&
  echo "�¹���... autoheader..." &&
  autoheader
fi &&
# Makefile.am ���ɤ߹��ߡ�Makefile.in ��������롣
if test "$ENABLE_AUTOMAKE" = "yes"; then
  #echo "Running automake --add-missing $automake_flags..." &&
  echo "�¹���... automake --add-missing $automake_flags..." &&
  automake --add-missing $automake_flags
fi &&
# configure �μ¹ԡ�autogen.sh ������ץȤΰ��������Τޤ��Ϥ���롣
# config.cache ������Ȥ��Ϻ�����롣
rm -f config.cache &&
#echo "Running configure $conf_flags $@..." &&
echo "�¹���... configure $conf_flags $@..." &&
./configure $conf_flags "$@" &&

echo &&
#echo "Now type 'make' to compile '$PACKAGE'." &&
echo "������'$PACKAGE' ��ڤ��ि��� 'make' ��¹Ԥ��褦��" &&

# gettext �Ѥγ�ĥ��ʬ
(test -f po/POTFILES.in.example) &&
{
  #echo
  #echo "**Warning**: 'po/POTFILES.in' is probably generated by autogen.sh."
  #echo "If it is correct, You must check 'po/POTFILES.in'."
  echo
  echo "**�ٹ�**: 'po/POTFILES.in' �Ϥ����餯 '$0' �ˤ�ä�"
  echo "          ��ưŪ�˺�������ޤ�����"
  echo "          ɬ�� 'po/POTFILES.in' ���ǧ���Ƥ���������"
}

(test -f po/$PACKAGE.pot) &&
{
  echo
  for l in $ALL_LINGUAS; do
    po=po/$l.po
    if test ! -s $po; then
      #echo "**�ٹ�**: '$po' is empty. You have to edit this file from '$PACKAGE.pot'."
      echo "**�ٹ�**: '$po' �����Ǥ���"
      echo "          $PACKAGE.pot' �����������ɬ�פ�����ޤ���"
    fi
  done
}

exit 0

#------------------------------------------------------------
#
