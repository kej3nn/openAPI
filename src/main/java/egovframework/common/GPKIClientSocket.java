package egovframework.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;

import com.gpki.gpkiapi.GpkiApi;
import com.gpki.gpkiapi.cert.X509Certificate;
import com.gpki.gpkiapi.cms.SignedAndEnvelopedData;
import com.gpki.gpkiapi.exception.GpkiApiException;
import com.gpki.gpkiapi.storage.Disk;
import com.gpki.gpkiapi.util.Base64;
import com.gpki.gpkiapi.util.Ldap;

public class GPKIClientSocket {
    public static String GPKILoginCert(HashMap paramHashMap) throws GpkiApiException, IOException {

        String str1 = paramHashMap.get("signCertPath").toString();
        String str2 = paramHashMap.get("signKeyPath").toString();
        String str3 = paramHashMap.get("kmCertPath").toString();
        String str4 = paramHashMap.get("kmKeyPath").toString();
        String str5 = paramHashMap.get("certPasswd").toString();

        Ldap localLdap = null;
        X509Certificate localX509Certificate = null;
        Base64 localBase64 = null;

        byte[] arrayOfByte1 = null;

        URL localURL = null;
        URLConnection localURLConnection = null;
        BufferedReader localBufferedReader = null;

        SignedAndEnvelopedData localSignedAndEnvelopedData1 = null;
        SignedAndEnvelopedData localSignedAndEnvelopedData2 = null;

        byte[] arrayOfByte2 = null;
        byte[] arrayOfByte3 = null;
        String str6 = "";
        String str7 = "";

        if ((paramHashMap.get("sData") == null) || (paramHashMap.get("sData").equals(""))) return "0";

        String str8 = paramHashMap.get("sData").toString();
        str8 = URLEncoder.encode(str8, "UTF-8");
        arrayOfByte2 = str8.getBytes();

        GpkiApi.init("/sysapp/tmax/PDF-J_2.0/gpki/");

        String str9 = "";

        localBase64 = new Base64();

        localLdap = new Ldap();
        localLdap.setLdap("cen.dir.go.kr", 389);

        arrayOfByte1 = localLdap.getData(3, "cn=SVR1311361003,ou=Group of Server,o=Government of Korea,c=KR");

        localX509Certificate = new X509Certificate(arrayOfByte1);

        localSignedAndEnvelopedData1 = new SignedAndEnvelopedData();
        localSignedAndEnvelopedData1.setMyCert(Disk.readCert(str1), Disk.readPriKey(str2, str5));
        arrayOfByte3 = localSignedAndEnvelopedData1.generate(localX509Certificate, arrayOfByte2);

        str6 = localBase64.encode(arrayOfByte3);

        localURL = new URL("http://rcen.egov.go.kr/servlets/mopas/jumin/main/MopasJuminCheck");
        localURLConnection = localURL.openConnection();
        localURLConnection.setDoOutput(true);

        PrintWriter localPrintWriter = new PrintWriter(localURLConnection.getOutputStream());
        localPrintWriter.print("data=" + URLEncoder.encode(str6, "UTF-8"));
        localPrintWriter.close();

        localBufferedReader = new BufferedReader(new InputStreamReader(localURLConnection.getInputStream()));

        if ((str7 = localBufferedReader.readLine()) != null) {
            byte[] arrayOfByte4 = localBase64.decode(str7);
            localSignedAndEnvelopedData2 = new SignedAndEnvelopedData();
            localSignedAndEnvelopedData2.setMyCert(Disk.readCert(str3), Disk.readPriKey(str4, str5));
            byte[] arrayOfByte5 = localSignedAndEnvelopedData2.process(arrayOfByte4);

            str9 = new String(arrayOfByte5, 0, arrayOfByte5.length);

            str9 = URLDecoder.decode(str9, "UTF-8");
        }
        return str9;
    }
}