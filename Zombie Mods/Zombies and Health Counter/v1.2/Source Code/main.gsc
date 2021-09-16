init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread healthCounter();
        player thread zombieCounter();
    }
}

healthCounter ()
{
	self endon ("disconnect");
	level endon( "end_game" );
	common_scripts/utility::flag_wait( "initial_blackscreen_passed" );
	self.healthText = maps/mp/gametypes_zm/_hud_util::createFontString ("hudsmall", 1.5);
	self.healthText maps/mp/gametypes_zm/_hud_util::setPoint ("CENTER", "CENTER", 100, 180);
	self.healthText.label = &"Health: ^2";
	while ( 1 )
	{
		self.healthText setValue(self.health);
		wait 0.25;
	}
}

zombieCounter()
{
	self endon( "disconnect" );
	level endon( "end_game" );
	common_scripts/utility::flag_wait( "initial_blackscreen_passed" );
    self.zombieText = maps/mp/gametypes_zm/_hud_util::createFontString( "hudsmall" , 1.5 );
    self.zombieText maps/mp/gametypes_zm/_hud_util::setPoint( "CENTER", "CENTER", -100, 180 );
    while( 1 )
    {
        self.zombieText setValue( ( maps/mp/zombies/_zm_utility::get_round_enemy_array().size + level.zombie_total ) );
        if( ( maps/mp/zombies/_zm_utility::get_round_enemy_array().size + level.zombie_total ) != 0 )
        {
        	self.zombieText.label = &"Zombies: ^1";
        }
        else
        {
        	self.zombieText.label = &"Zombies: ^6";
        }
        wait 0.25;
    }
}
