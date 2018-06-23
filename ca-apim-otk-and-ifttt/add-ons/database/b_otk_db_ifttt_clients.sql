-- CA Technologies 2018
-- Database test data for OTK-4.2
--
-- Delete the existing test clients to install them again
--
delete from oauth_client where client_ident = 'IFTTT-123456800-otk';
delete from oauth_client_key where client_ident = 'IFTTT-123456800-otk';
delete from oauth_client where client_ident = 'IFTTT-123456800-otk-bank';
delete from oauth_client_key where client_ident = 'IFTTT-123456800-otk-bank';
--
-- IFTTT Client
--
insert into oauth_client (client_ident, name, description, organization, registered_by, type, custom)
values ('IFTTT-123456800-otk', 'IFTTT', 'Tutorial Client for OTK and IFTTT', 'CA Technologies Inc.', 'admin', 'confidential', '{}');
insert into oauth_client_key (client_key, secret, status, created_by, client_ident, client_name, callback, scope, custom)
values ('8dd8d732-3e76-405e-8598-c26453d9a99f', '98c14eee-39ab-4bf4-b3d6-d42262a884d9', 'ENABLED', 'admin', 'IFTTT-123456800-otk', 'IFTTT', 'https://otk-ifttt.tutorial.com/oauth/v2/client/bcp?auth=done', 'ifttt', '{}');
--
-- IFTTT 'CA OTK Tutorial Bank'
--
insert into oauth_client (client_ident, name, description, organization, registered_by, type, custom)
values ('IFTTT-123456800-otk-bank', 'CA OTK Tutorial Bank', 'Tutorial Client for OTK and IFTTT', 'CA Technologies Inc.', 'admin', 'confidential', '{}');
insert into oauth_client_key (client_key, secret, status, created_by, client_ident, client_name, callback, scope, custom)
values ('4416dc58-6d00-41c5-b30a-c1d2c6d8dfc0', '4dd0c819-378c-4ead-8c27-e1a23f0e79b9', 'ENABLED', 'admin', 'IFTTT-123456800-otk-bank', 'CA OTK Tutorial Bank', 'https://otk-ifttt.tutorial.com/tutorial/otk/ifttt/bank?action=token&provider=bank', 'openid email profile banking', '{}');
