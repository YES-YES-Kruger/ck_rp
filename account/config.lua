Request_account = switch {
  ["IfplayerAccountExist"] = "SELECT id FROM accounts WHERE steam_id = '?' LIMIT 1;",
  ["CreatePlayerAccount"] = "INSERT INTO accounts (id, admin, steam_id, health, armor, name, cash, cash_account) VALUES (NULL, '?', '?', '?', '?', '?', '?', '?');",
  ["GetPlayerAccount"] = "SELECT accounts.id,admin_level, steam_id, health, armor, player_name, cash, cash_account FROM account_administrator RIGHT JOIN accounts ON account_administrator.account_id = accounts.id WHERE steam_id = '?';",
  ["SaveAccount"] = "UPDATE accounts SET cash= ?, cash_account=?, health= ?, armor=?  WHERE steam_id = ? LIMIT 1;",
}

Config_new_account = switch {
  ["cash"] = 500,
  ["cash_account"] = 15000,
  ["health"] = 100,
  ["armor"] = 50,
}

Config_other_account = switch {
  ["save_time"] = 300000, -- milisecond (1 min = 60000 milisecond) default - 300000
}

