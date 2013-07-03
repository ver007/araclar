#!/usr/bin/python
# -*- coding: utf-8 -*-
# By Gokhan ALKAN
# twitter: @cigalkan , web site: http://www.agguvenligi.net/


__author__ = 'Galkan'
__version__ = '1.0'
__date__ = '2013'

try: 
     import httplib
     import sys
except ImportError,e:
     import sys
     sys.stdout.write("%s" %e) 
     sys.exit(1)


def print_proxy_auth (ip_addr, port):

      httpconnection = httplib.HTTPConnection("%s"% (ip_addr),port)

      try:
            httpconnection.request('HEAD', 'http://www.google.com')
      except:
            print "%s:%s Soketine Baglanti Saglanamiyor."% (ip_addr,port)
            sys.exit (1)

      response = httpconnection.getresponse()

      if response.status == 407:
           data = response.getheaders()
           control = 0

      for line in data:
            if line[0] == "proxy-authenticate":
            print line[0] + " -> " + line[1]
           
            control = 1
            if control == 0:
                print "Proxy Yetkilendirm Turu Belirlenemedi"
                sys.exit(2)
           else:
                print "Proxy Yetkilendirme Istemiyor !!!"
                sys.exit(3)

###
# By Galkan 
# twitter: @cigalkan
###

if __name__ == "__main__":

       if not len(sys.argv) == 3:
              print "Kullanim: %s ip_address port"% (sys.argv[0])
       else:
              ip_addr = sys.argv[1]
              port = int(sys.argv[2])

       print_proxy_auth (ip_addr, port)
