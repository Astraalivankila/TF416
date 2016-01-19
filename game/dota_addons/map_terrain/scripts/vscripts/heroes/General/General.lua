function GeneralCharge(keys)
	local caster = keys.caster
	local ability = keys.ability
	local modifier_charge = keys.modifier_charge
	local ability_level = ability:GetLevel() - 1	
	local duration = ability:GetLevelSpecialValueFor("duration",ability_level)
	local movementspeed = ability:GetLevelSpecialValueFor("movement_speed",ability_level)
	local range = ability:GetLevelSpecialValueFor("range",ability_level)
	local troops = FindUnitsInRadius(caster:GetTeam(),caster:GetAbsOrigin(),nil,range,DOTA_UNIT_TARGET_TEAM_FRIENDLY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NONE,FIND_ANY_ORDER,false)

	for _,troop in pairs(troops) do
		ability:ApplyDataDrivenModifier(caster,troop,modifier_charge,{duration = duration})
	end
end

function GeneralChargeImpact(keys)
	local caster = keys.caster
	local target = keys.target	
	local ability = keys.ability
	local modifier_charge = keys.modifier_charge
	local ability_level = ability:GetLevel() - 1	
	local radius = ability:GetLevelSpecialValueFor("radius",ability_level)
	local damage = ability:GetLevelSpecialValueFor("damage",ability_level)
	local duration = ability:GetLevelSpecialValueFor("stun_strength",ability_level)


	ApplyDamage({victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL})
	target:AddNewModifier(caster, ability, "modifier_stunned", {duration = duration})

end

function GeneralRally(keys)
	local caster = keys.caster
	local target = keys.target
	local modifier_rally = keys.modifier_rally
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1	
	local radius = ability:GetLevelSpecialValueFor("radius",ability_level)		
	local duration = ability:GetLevelSpecialValueFor("duration",ability_level)
	local allies = FindUnitsInRadius(caster:GetTeam(),caster:GetAbsOrigin(),nil,radius,DOTA_UNIT_TARGET_TEAM_FRIENDLY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NONE,FIND_ANY_ORDER,false)

	for _,ally in pairs(allies) do
		ability:ApplyDataDrivenModifier(caster,ally,modifier_rally,{duration = duration})
	end	
end	

function GeneralRallyHeal(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local heal = ability:GetLevelSpecialValueFor("heal",ability_level)

	target:Heal(heal,caster)
	target:Purge(false,true,false,false,false)	
end