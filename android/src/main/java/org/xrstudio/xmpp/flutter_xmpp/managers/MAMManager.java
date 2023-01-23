package org.xrstudio.xmpp.flutter_xmpp.managers;

import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smack.tcp.XMPPTCPConnection;
import org.jivesoftware.smackx.mam.MamManager;
import org.xrstudio.xmpp.flutter_xmpp.Connection.FlutterXmppConnection;
import org.xrstudio.xmpp.flutter_xmpp.Utils.Utils;

import java.util.Date;
import java.util.List;

public class MAMManager {


    public static void requestMAM(String userJid, String requestBefore, String requestSince, String limit) {

        XMPPTCPConnection connection = FlutterXmppConnection.getConnection();

        if (connection.isAuthenticated()) {

            try {

                MamManager mamManager = MamManager.getInstanceFor(connection);
                MamManager.MamQueryArgs.Builder queryArgs = MamManager.MamQueryArgs.builder();
                long requestAfterts = Long.parseLong(requestSince);
                if (requestAfterts > 0)
                    queryArgs.limitResultsSince(new Date(requestAfterts));

                int limitMessage = Integer.parseInt(limit);
                if (limitMessage > 0) {
                    queryArgs.setResultPageSizeTo(limitMessage);
                } else {
                    queryArgs.setResultPageSizeTo(Integer.MAX_VALUE);
                }

                queryArgs.queryLastPage();

                queryArgs.build();
                Utils.printLog("MAM query Args " + queryArgs.toString());
                org.jivesoftware.smackx.mam.MamManager.MamQuery query = mamManager.queryArchive(queryArgs.build());
                List<Message> messageList = query.getMessages();

                Utils.printLog("HISTORY CHAT LENGTH " + messageList.size());
                for (Message message : messageList) {
                    Utils.broadcastMessageToFlutter(FlutterXmppConnection.getApplicationContext(), message);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }

}
