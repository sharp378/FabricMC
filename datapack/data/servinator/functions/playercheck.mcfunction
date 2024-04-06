# stop server if no players connected
execute unless entity @a run function servinator:stopserver
execute if entity @a run function servinator:load
