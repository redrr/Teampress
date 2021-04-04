package hu.playmaker.common.template;

public class MailTemplates {

    public static String welcome(String... args) {
        return
                "<!DOCTYPE html>\n" +
                "<html lang=\"en\" xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n" +
                "<head>\n" +
                "  <meta charset=\"utf-8\">\n" +
                "  <meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">\n" +
                "  <meta name=\"x-apple-disable-message-reformatting\">\n" +
                "  <title></title>\n" +
                "  <!--[if mso]>\n" +
                "  <style>\n" +
                "    table {border-collapse:collapse;border-spacing:0;border:none;margin:0;}\n" +
                "    div, td {padding:0;}\n" +
                "    div {margin:0 !important;}\n" +
                "  </style>\n" +
                "  <noscript>\n" +
                "    <xml>\n" +
                "      <o:OfficeDocumentSettings>\n" +
                "        <o:PixelsPerInch>96</o:PixelsPerInch>\n" +
                "      </o:OfficeDocumentSettings>\n" +
                "    </xml>\n" +
                "  </noscript>\n" +
                "  <![endif]-->\n" +
                "  <style>\n" +
                "    table, td, div, h1, p {\n" +
                "      font-family: Arial, sans-serif;\n" +
                "    }\n" +
                "    @media screen and (max-width: 530px) {\n" +
                "      .unsub {\n" +
                "        display: block;\n" +
                "        padding: 8px;\n" +
                "        margin-top: 14px;\n" +
                "        border-radius: 6px;\n" +
                "        background-color: #555555;\n" +
                "        text-decoration: none !important;\n" +
                "        font-weight: bold;\n" +
                "      }\n" +
                "      .col-lge {\n" +
                "        max-width: 100% !important;\n" +
                "      }\n" +
                "    }\n" +
                "    @media screen and (min-width: 531px) {\n" +
                "      .col-sml {\n" +
                "        max-width: 27% !important;\n" +
                "      }\n" +
                "      .col-lge {\n" +
                "        max-width: 73% !important;\n" +
                "      }\n" +
                "    }\n" +
                "  </style>\n" +
                "</head>\n" +
                "<body style=\"margin:0;padding:0;word-spacing:normal;background-color:#fff;\">\n" +
                "  <div role=\"article\" aria-roledescription=\"email\" lang=\"en\" style=\"text-size-adjust:100%;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;background-color:#fff;\">\n" +
                "    <table role=\"presentation\" style=\"width:100%;border:none;border-spacing:0;\">\n" +
                "      <tr>\n" +
                "        <td align=\"center\" style=\"padding:0;\">\n" +
                "          <!--[if mso]>\n" +
                "          <table role=\"presentation\" align=\"center\" style=\"width:600px;\">\n" +
                "          <tr>\n" +
                "          <td>\n" +
                "          <![endif]-->\n" +
                "          <table role=\"presentation\" style=\"width:94%;max-width:600px;border:none;border-spacing:0;text-align:left;font-family:Arial,sans-serif;font-size:16px;line-height:22px;color:#363636;\">\n" +
                "            <tr>\n" +
                "              <td style=\"padding:30px;text-align:center;font-size:12px;background-color:#2C3E50;color:#fff;\">\n" +
                "                <p style=\"margin:0;font-size:14px;line-height:20px;\">Logo</p>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "            <tr>\n" +
                "              <td style=\"padding:30px;background-color:#ffffff;\">\n" +
                "                <h1 style=\"margin-top:0;margin-bottom:36px;font-size:26px;line-height:32px;font-weight:bold;letter-spacing:-0.02em;\">Üdvözlünk a Teampress-en!</h1>\n" +
                "                <p style=\"margin:0;\">A regisztrációd véglegesítéséhez az alábbi gombra kattintva állítsd be a jelszavad.</p>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "            <tr>\n" +
                "              <td style=\"padding:35px 30px 11px 30px;font-size:0;background-color:#ffffff;border-bottom:1px solid #f0f0f5;border-color:rgba(201,201,207,.35);\">\n" +
                "                <!--[if mso]>\n" +
                "                <table role=\"presentation\" width=\"100%\">\n" +
                "                <tr>\n" +
                "                <td style=\"width:145px;\" align=\"left\" valign=\"top\">\n" +
                "                <![endif]-->\n" +
                "                <div class=\"col-sml\" style=\"display:inline-block;width:100%;max-width:145px;vertical-align:top;text-align:left;font-family:Arial,sans-serif;font-size:14px;color:#363636;\">\n" +
                "                </div>\n" +
                "                <!--[if mso]>\n" +
                "                </td>\n" +
                "                <td style=\"width:395px;padding-bottom:20px;\" valign=\"top\">\n" +
                "                <![endif]-->\n" +
                "                <div class=\"col-lge\" style=\"display:inline-block;width:100%;max-width:395px;vertical-align:top;padding-bottom:20px;font-family:Arial,sans-serif;font-size:16px;line-height:22px;color:#363636;\">\n" +
                "                  <p style=\"margin:0;\"><a href=\""+args[0]+"\" style=\"background: #2ED8B5; text-decoration: none; padding: 10px 25px; color: #ffffff; border-radius: 8px; display:inline-block; mso-padding-alt:0;text-underline-color:#ff3884\"><!--[if mso]><i style=\"letter-spacing: 25px;mso-font-width:-100%;mso-text-raise:20pt\">&nbsp;</i><![endif]--><span style=\"mso-text-raise:10pt;font-weight:bold;\">Véglegesítés</span><!--[if mso]><i style=\"letter-spacing: 25px;mso-font-width:-100%\">&nbsp;</i><![endif]--></a></p>\n" +
                "                </div>\n" +
                "                <!--[if mso]>\n" +
                "                </td>\n" +
                "                </tr>\n" +
                "                </table>\n" +
                "                <![endif]-->\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "            <tr>\n" +
                "              <td style=\"padding:30px;text-align:center;font-size:12px;background-color:#2C3E50;color:#cccccc;\">\n" +
                "                <p style=\"margin:0;font-size:14px;line-height:20px;\">&reg; Teampress 2021</p>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "          </table>\n" +
                "          <!--[if mso]>\n" +
                "          </td>\n" +
                "          </tr>\n" +
                "          </table>\n" +
                "          <![endif]-->\n" +
                "        </td>\n" +
                "      </tr>\n" +
                "    </table>\n" +
                "  </div>\n" +
                "</body>\n" +
                "</html>";
    }

    public static String changePassword(String... args) {
        return
                "<!DOCTYPE html>\n" +
                "<html lang=\"en\" xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n" +
                "<head>\n" +
                "  <meta charset=\"utf-8\">\n" +
                "  <meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">\n" +
                "  <meta name=\"x-apple-disable-message-reformatting\">\n" +
                "  <title></title>\n" +
                "  <!--[if mso]>\n" +
                "  <style>\n" +
                "    table {border-collapse:collapse;border-spacing:0;border:none;margin:0;}\n" +
                "    div, td {padding:0;}\n" +
                "    div {margin:0 !important;}\n" +
                "  </style>\n" +
                "  <noscript>\n" +
                "    <xml>\n" +
                "      <o:OfficeDocumentSettings>\n" +
                "        <o:PixelsPerInch>96</o:PixelsPerInch>\n" +
                "      </o:OfficeDocumentSettings>\n" +
                "    </xml>\n" +
                "  </noscript>\n" +
                "  <![endif]-->\n" +
                "  <style>\n" +
                "    table, td, div, h1, p {\n" +
                "      font-family: Arial, sans-serif;\n" +
                "    }\n" +
                "    @media screen and (max-width: 530px) {\n" +
                "      .unsub {\n" +
                "        display: block;\n" +
                "        padding: 8px;\n" +
                "        margin-top: 14px;\n" +
                "        border-radius: 6px;\n" +
                "        background-color: #555555;\n" +
                "        text-decoration: none !important;\n" +
                "        font-weight: bold;\n" +
                "      }\n" +
                "      .col-lge {\n" +
                "        max-width: 100% !important;\n" +
                "      }\n" +
                "    }\n" +
                "    @media screen and (min-width: 531px) {\n" +
                "      .col-sml {\n" +
                "        max-width: 27% !important;\n" +
                "      }\n" +
                "      .col-lge {\n" +
                "        max-width: 73% !important;\n" +
                "      }\n" +
                "    }\n" +
                "  </style>\n" +
                "</head>\n" +
                "<body style=\"margin:0;padding:0;word-spacing:normal;background-color:#fff;\">\n" +
                "  <div role=\"article\" aria-roledescription=\"email\" lang=\"en\" style=\"text-size-adjust:100%;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;background-color:#fff;\">\n" +
                "    <table role=\"presentation\" style=\"width:100%;border:none;border-spacing:0;\">\n" +
                "      <tr>\n" +
                "        <td align=\"center\" style=\"padding:0;\">\n" +
                "          <!--[if mso]>\n" +
                "          <table role=\"presentation\" align=\"center\" style=\"width:600px;\">\n" +
                "          <tr>\n" +
                "          <td>\n" +
                "          <![endif]-->\n" +
                "          <table role=\"presentation\" style=\"width:94%;max-width:600px;border:none;border-spacing:0;text-align:left;font-family:Arial,sans-serif;font-size:16px;line-height:22px;color:#363636;\">\n" +
                "            <tr>\n" +
                "              <td style=\"padding:30px;text-align:center;font-size:12px;background-color:#2C3E50;color:#fff;\">\n" +
                "                <p style=\"margin:0;font-size:14px;line-height:20px;\">Logo</p>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "            <tr>\n" +
                "              <td style=\"padding:30px;background-color:#ffffff;\">\n" +
                "                <h1 style=\"margin-top:0;margin-bottom:36px;font-size:26px;line-height:32px;font-weight:bold;letter-spacing:-0.02em;\">Kedves "+args[0]+"!</h1>\n" +
                "                <p style=\"margin:0;\">Jelszavadat töröltük, az alábbi gomb segítségével tudod beállítani az újat.</p>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "            <tr>\n" +
                "              <td style=\"padding:35px 30px 11px 30px;font-size:0;background-color:#ffffff;border-bottom:1px solid #f0f0f5;border-color:rgba(201,201,207,.35);\">\n" +
                "                <!--[if mso]>\n" +
                "                <table role=\"presentation\" width=\"100%\">\n" +
                "                <tr>\n" +
                "                <td style=\"width:145px;\" align=\"left\" valign=\"top\">\n" +
                "                <![endif]-->\n" +
                "                <div class=\"col-sml\" style=\"display:inline-block;width:100%;max-width:145px;vertical-align:top;text-align:left;font-family:Arial,sans-serif;font-size:14px;color:#363636;\">\n" +
                "                </div>\n" +
                "                <!--[if mso]>\n" +
                "                </td>\n" +
                "                <td style=\"width:395px;padding-bottom:20px;\" valign=\"top\">\n" +
                "                <![endif]-->\n" +
                "                <div class=\"col-lge\" style=\"display:inline-block;width:100%;max-width:395px;vertical-align:top;padding-bottom:20px;font-family:Arial,sans-serif;font-size:16px;line-height:22px;color:#363636;\">\n" +
                "                  <p style=\"margin:0;\"><a href=\""+args[1]+"\" style=\"background: #2ED8B5; text-decoration: none; padding: 10px 25px; color: #ffffff; border-radius: 8px; display:inline-block; mso-padding-alt:0;text-underline-color:#ff3884\"><!--[if mso]><i style=\"letter-spacing: 25px;mso-font-width:-100%;mso-text-raise:20pt\">&nbsp;</i><![endif]--><span style=\"mso-text-raise:10pt;font-weight:bold;\">Új jelszó</span><!--[if mso]><i style=\"letter-spacing: 25px;mso-font-width:-100%\">&nbsp;</i><![endif]--></a></p>\n" +
                "                </div>\n" +
                "                <!--[if mso]>\n" +
                "                </td>\n" +
                "                </tr>\n" +
                "                </table>\n" +
                "                <![endif]-->\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "            <tr>\n" +
                "              <td style=\"padding:30px;text-align:center;font-size:12px;background-color:#2C3E50;color:#cccccc;\">\n" +
                "                <p style=\"margin:0;font-size:14px;line-height:20px;\">&reg; Teampress 2021</p>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "          </table>\n" +
                "          <!--[if mso]>\n" +
                "          </td>\n" +
                "          </tr>\n" +
                "          </table>\n" +
                "          <![endif]-->\n" +
                "        </td>\n" +
                "      </tr>\n" +
                "    </table>\n" +
                "  </div>\n" +
                "</body>\n" +
                "</html>";
    }
}
