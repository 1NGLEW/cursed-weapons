// Client
SWEP.PrintName      = "prop pistol"	
SWEP.Slot		    = 4
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
SWEP.Instructions	= "press R to open props menu"
SWEP.Category = "cursed weapons"
SWEP.Recoil 		= 3

SWEP.Spawnable = true
SWEP.AdminOnly = true
 
SWEP.ViewModel		= "models/weapons/c_pistol.mdl"
SWEP.WorldModel		= "models/weapons/w_pistol.mdl"
SWEP.UseHands = true
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "RPG_Round"
SWEP.Primary.Damage = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
 
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
 
local ShootSound = Sound( "weapons/airboat/airboat_gun_energy1.wav" )

/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()

  local Panel = vgui.Create( "DFrame" )
  Panel:SetPos( 200, 200 )
  Panel:SetSize( 200, 200 )
  Panel:SetTitle( "Spawn Icon Test" )
  Panel:MakePopup()

local SpawnI = vgui.Create( "SpawnIcon" , Panel )
SpawnI:SetPos( 75, 75 )
SpawnI:SetModel( "models/props_borealis/bluebarrel001.mdl" )

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
 
	local owner = self:GetOwner()

    -- Make sure the weapon is being held before trying to throw a chair
    if ( not owner:IsValid() ) then return end

    if ( CLIENT ) then return end

    -- Create a prop_physics entity
    local ent = ents.Create( "prop_physics" )

    -- Always make sure that created entities are actually created!
    if ( not ent:IsValid() ) then return end

    -- Set the entity's model to the passed in model
    local model_file = "models/props_junk/sawblade001a.mdl"
     ent:SetModel( model_file )
    local aimvec = owner:GetAimVector()
    local pos = aimvec * 16 -- This creates a new vector object
    pos:Add( owner:EyePos() ) -- This translates the local aimvector to world coordinates

    -- Set the position to the player's eye position plus 16 units forward.
    ent:SetPos( pos )

    -- Set the angles to the player'e eye angles. Then spawn it.
    ent:SetAngles( owner:EyeAngles() )
    ent:Spawn()
    self:EmitSound(ShootSound)
 
    local phys = ent:GetPhysicsObject()
    if ( not phys:IsValid() ) then ent:Remove() return end
 
    aimvec:Mul( 1000000 )
    aimvec:Add( VectorRand( -10, 10 ) ) -- Add a random vector with elements [-10, 10)
    phys:ApplyForceCenter( aimvec )
 
    cleanup.Add( owner, "props", ent )
 
    undo.Create( "cursed bullet" )
        undo.AddEntity( ent )
        undo.SetPlayer( owner )
    undo.Finish()
 
end