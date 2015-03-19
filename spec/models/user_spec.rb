require 'spec_helper'

describe User do
  it 'should have stalkers and stalkees' do
    bob = User.create!
    sam = User.create!
    laura = User.create!
    jen = User.create!
    alph = User.create!

    bob.stalkees << sam
    bob.stalkees << jen
    bob.stalkers << laura
    bob.stalkers << alph
    bob.save!

    bob.reload

    expect(bob.stalkees).to include sam
    expect(bob.stalkees).to include jen
    expect(bob.stalkers).to include laura
    expect(bob.stalkers).to include alph

    expect(sam.stalkers  ).to include bob
    expect(jen.stalkers  ).to include bob
    expect(laura.stalkees).to include bob
    expect(alph.stalkees ).to include bob

    stalkee_relationships = bob.stalkee_relationships.map do |stalkee_relationship|
      {
        stalker_id: stalkee_relationship.stalker_id,
        stalkee_id: stalkee_relationship.stalkee_id,
      }
    end

    expect(stalkee_relationships).to include({stalkee_id: sam.id, stalker_id: bob.id})
    expect(stalkee_relationships).to include({stalkee_id: jen.id, stalker_id: bob.id})

    stalker_relationships = bob.stalker_relationships.map do |stalker_relationship|
      {
        stalker_id: stalker_relationship.stalker_id,
        stalkee_id: stalker_relationship.stalkee_id,
      }
    end

    expect(stalker_relationships).to include({stalkee_id: bob.id, stalker_id: laura.id})
    expect(stalker_relationships).to include({stalkee_id: bob.id, stalker_id: alph.id})
  end
end
