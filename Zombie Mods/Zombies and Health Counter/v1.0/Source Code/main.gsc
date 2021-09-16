init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread healthPlayer();
        player thread drawZombiesCounter();
    }
}

healthPlayer()
{
	self endon("disconnect");
	self.healthText = createFontString("Objective" , 1.5);
        self.healthText setPoint("CENTER", "CENTER", 100, 180);
        while(true)
              {
               self.healthText setText( "Health: ^2"+ self.health);
               wait 0.5;
              }
}

drawZombiesCounter()
{
	self endon( "disconnect" );
	level endon( "end_game" );
	level waittill( "start_of_round" );
    self.zombiesCounter = maps/mp/gametypes_zm/_hud_util::createFontString( "hudsmall" , 1.5 );
    self.zombiesCounter maps/mp/gametypes_zm/_hud_util::setPoint( "CENTER", "CENTER", -100, 180 );
    self.zombiesCounter.alpha = 0;
    while( 1 )
    {
        self.zombiesCounter setValue( ( maps/mp/zombies/_zm_utility::get_round_enemy_array().size + level.zombie_total ) );
        if( ( maps/mp/zombies/_zm_utility::get_round_enemy_array().size + level.zombie_total ) != 0 )
        {
        	self.zombiesCounter.label = &"Zombies: ^1";
        	if( self.zombiesCounter.alpha != 1 )
        	{
        		self.zombiesCounter fadeovertime( 0.5 );
    			self.zombiesCounter.alpha = 1;
    		}
        }
        else
        {
        	self.zombiesCounter.label = &"Zombies: ^6";
        	for( i = 0; i < 15; i++ )
        	{
        		if( self.zombiesCounter.alpha == 1 )
        		{
        			self.zombiesCounter fadeovertime( 0.5 );
    				self.zombiesCounter.alpha = 0;
    			}
    			else
    			{
    				self.zombiesCounter fadeovertime( 0.5 );
    				self.zombiesCounter.alpha = 1;
    			}
    			wait 0.5;
    		}
        	level waittill( "start_of_round" );
        }
        wait 0.05;
    }
}

