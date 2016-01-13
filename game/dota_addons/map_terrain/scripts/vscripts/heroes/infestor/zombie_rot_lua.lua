function zombie_rot_incubation(keys)
    local ability = keys.ability
    local caster = keys.caster
    local buff_duration = keys.buff_duration
    local target = keys.target
    local abilitydamage = keys.AbilityDamage
    local zombie_rot_onset = keys.zombie_rot_onset   
    local zombie_rot_incubation = keys.zombie_rot_incubation
    local victims = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, 100, 
              DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 
              DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

        for _,victim in pairs(victims) do

                if not victim:HasModifier(zombie_rot_incubation) then
                     ability:ApplyDataDrivenModifier(caster, victim, zombie_rot_incubation, buff_duration)  
                    else 
               AddStacks(ability, caster, victim, zombie_rot_incubation, 1, true)
            end
          
       end
end


function zombie_rot_onset(keys)
    local target = keys.target
    local zombie_rot_incubation = keys.zombie_rot_incubation 
    local zombie_rot_onset = keys.zombie_rot_onset   
    local ability = keys.ability
    local caster = keys.caster
    local buff_duration = keys.buff_duration
    if (target:GetModifierStackCount(zombie_rot_incubation, ability) > 4 ) then
    ability:ApplyDataDrivenModifier(caster, target, zombie_rot_onset, buff_duration)
    RemoveStacks(ability, target, zombie_rot_incubation, 100)
    AddStacks(ability, caster, target, zombie_rot_onset, 1, true)
    end

end

function zombie_rot_damage(keys)
    local ability = keys.ability
    local ability_level = ability:GetLevel() - 1
    local caster = keys.caster
    local zombie_rot_onset = keys.zombie_rot_onset
    local target = keys.target
    local damage = ability:GetLevelSpecialValueFor("AbilityDamage", ability_level)
    local stack_count = target:GetModifierStackCount(zombie_rot_onset, caster)
 local damageTable = {victim = target, attacker = caster, damage = damage * stack_count, damage_type = DAMAGE_TYPE_MAGICAL,}
 
ApplyDamage(damageTable)
end
