class ProceedingTypePopulator

  DOMID = MatterType.domestic_abuse.id.freeze
  S8ID = MatterType.section_8.id.freeze

  SEED_DATA = [
    [
      'PR0200',
      'DA006',
      'Extend, variation or discharge - Part IV',
      'to be represented on an application to extend, vary or discharge an order under Part IV Family Law Act 1996',
      DOMID
    ],
    [
      'PR0203',
      'DA007',
      'Forced marriage protection order',
      'to be represented on an application for a forced marriage protection order',
      DOMID
    ],
    [
      'PR0206',
      'DA003',
      'Harassment - injunction',
      'to be represented in an action for an injunction under section 3 Protection from Harassment Act 1997.',
      DOMID
    ],
    [
      'PR0208',
      'DA001',
      'Inherent jurisdiction high court injunction',
      'to be represented on an application for an injunction, order or declaration under the inherent jurisdiction of the court.',
      DOMID
    ],
    [
      'PR0211',
      'DA004',
      'Non-molestation order',
      'to be represented on an application for a non-molestation order.',
      DOMID
    ],
    [
      'PR0214',
      'DA005',
      'Occupation order',
      'to be represented on an application for an occupation order.',
      DOMID
    ],
    [ 'PR0217',
      'DA002',
      'Variation or discharge under section 5 protection from harassment act 1997',
      'to be represented on an application to vary or discharge an order under section 5 Protection from Harassment Act 1997 where the parties are associated persons (as defined by Part IV Family Law Act 1996).',
      DOMID
    ],
    [
      'PR0220',
      'DA020',
      'FGM Protection Order',
      'To be represented on an application for a Female Genital Mutilation Protection Order under the Female Genital Mutilation Act.',
      DOMID
    ],
    [
      'SE003',
      'SE003',
      'Prohibited steps order',
      'to be represented on an application for a prohibited steps order.',
      S8ID
    ],
    [
      'SE004',
      'SE004',
      'Specific Issue Order',
      'to be represented on an application for a specific issue order.',
      S8ID
    ],
    [
      'SE013',
      'SE013',
      'Child arrangements order (contact)',
      'to be represented on an application for a child arrangements order-who the child(ren) spend time with.',
      S8ID
    ],
    [
      'SE014',
      'SE014',
      'Child arrangements order (residence)',
      'to be represented on an application for a child arrangements order –where the child(ren) will live',
      S8ID
    ],
  ]

  def self.call
    new.call
  end

  def call
    SEED_DATA.each { |seed_row| populate(seed_row) }
  end

  private

  def populate(seed_row)
    code, ccms_code, meaning, description, matter_type_id = seed_row
    record = ProceedingType.find_by(code: code) || ProceedingType.new
    record.update!(
      code: code,
      ccms_code: ccms_code,
      meaning: meaning,
      description: description,
      matter_type_id: matter_type_id
    )
  end

end

