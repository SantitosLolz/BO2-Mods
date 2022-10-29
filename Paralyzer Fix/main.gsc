init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread paralzyer_flying();
    	player thread paralzyer_check();
    }
}

paralzyer_flying()
{
    self endon("disconnect");
    level endon("end_game");
    
    self.flypower = 100;
    for(;;)
    {
        if(self.flypower < 100 && !isDefined(self.flying))
            self.flypower++;
        if(!isDefined(self.flying) && !self isOnGround())
            self.flying = true;
        else if(self isOnGround())
            self.flying = undefined;
        wait .05;
    }
}

paralzyer_check()
{
    self endon("disconnect");
    level endon("end_game");
    
    for(;;)
    {
        if(self getCurrentWeapon() == "slowgun_zm" || self getCurrentWeapon() == "slowgun_upgraded_zm")
        {
            if(self attackbuttonpressed())
            {
                foreach(player in level.players)
                {
                    if(distance(self.origin, player.origin) < 120 && isDefined(player.flying) && player.flypower > 0)
                    {
                        player.flypower--;
                        if(player getvelocity() [2] < 300)
                            player setvelocity(player getvelocity() + (0,0,41));
                    }
                }
            }
        }
        wait .05;
    }
}
