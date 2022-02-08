// Client
SWEP.PrintName      = "ultrasmg"	
SWEP.Slot		    = 2
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= true
SWEP.DrawCrosshair	= true

// Server
SWEP.Weight		    = 1
SWEP.AutoSwitchTo	= false
SWEP.AutoSwitchFrom	= false


// Both
SWEP.Author			= "Aki, Ashura09"
SWEP.Contact		= ""
SWEP.Purpose		= "for fun"
SWEP.Instructions	= "just shot"
SWEP.Category = "cursed weapons"
SWEP.Recoil 		= 3

SWEP.Spawnable = true
SWEP.AdminOnly = true
 
SWEP.ViewModel		= "models/weapons/c_smg1.mdl"
SWEP.WorldModel		= "models/weapons/w_smg1.mdl"
SWEP.UseHands = true
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"
SWEP.Primary.Damage = 30

SWEP.Secondary.Ammo = "none"
 
local ShootSound = Sound( "weapons/slam/mine_mode.wav" )

/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
end
 
/*---------------------------------------------------------
  Think does nothing
---------------------------------------------------------*/
function SWEP:Think()	
end
 
/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/

function SWEP:PrimaryAttack()
    local ply = self:GetOwner()

    ply:LagCompensation(true)
    local tr = self.Owner:GetEyeTrace()

    local Bullet = {}
        Bullet.Num = self.Primary.NumShots
        Bullet.Src = ply:GetShootPos()
        Bullet.Dir = self.Owner:GetAimVector()
        Bullet.Spread = Vector( self.Primary.Spread, self.Primary.Spread, 0)
        Bullet.Tracer = 0
        Bullet.Damage = self.Primary.Damage
        Bullet.AmmoType = self.Primary.Ammo

    self:FireBullets(Bullet)
    self:ShootEffects()
    self:SetNextPrimaryFire(0.1)
    self:EmitSound(ShootSound)
 
end