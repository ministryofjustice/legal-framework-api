require "rails_helper"

RSpec.describe QuestionsService do
  subject(:question_service) { described_class.call(question_params) }

  let(:question_params) do
    {
      request_id:,
      proceedings:,
    }.to_json
  end

  let(:request_id) { SecureRandom.uuid }

  let(:proceedings) do
    [
      {
        ccms_code:,
        delegated_functions_used:,
        client_involvement_type:,
      },
    ]
  end

  let(:ccms_code) { "DA005" }
  let(:client_involvement_type) { "A" }
  let(:delegated_functions_used) { true }
  let(:proceeding_tasks_for_ccms_code) { question_service[:proceedings].find { |p| p[:ccms_code] == ccms_code }[:tasks] }

  context "when the request succeeds" do
    context "when there is a DA proceeding with CIT of applicant" do
      it "returns valid response with expected tasks" do
        expect(question_service).to eq expected_da005_applicant_response
      end
    end

    context "when there is a DA proceeding with CIT of Defendant" do
      let(:client_involvement_type) { "D" }

      it "returns valid response with questions 7 & 8" do
        expect(question_service).to eq expected_da005_defendant_response
      end
    end

    context "when there is a DA proceeding as Applicant and a Child Section 8 with CIT of Defendant" do
      let(:proceedings) do
        [
          {
            ccms_code: "DA005",
            delegated_functions_used: true,
            client_involvement_type: "A",
          },
          {
            ccms_code: "SE013",
            delegated_functions_used: true,
            client_involvement_type: "D",
          },
        ]
      end

      it "returns valid response without domestic abuse/non applicant questions" do
        expect(question_service).to eq expected_multiple_no_questions_response_with_defendant
      end
    end

    context "when there is a DA proceeding as Applicant and a Child Section 8 as Applicant" do
      let(:proceedings) do
        [
          {
            ccms_code: "DA005",
            delegated_functions_used: true,
            client_involvement_type: "A",
          },
          {
            ccms_code: "SE013",
            delegated_functions_used: true,
            client_involvement_type: "A",
          },
        ]
      end

      it "returns valid response without domestic abuse/non applicant questions" do
        expect(question_service).to eq expected_multiple_no_questions_response
      end
    end

    context "when there are two DA proceedings with one as Applicant and one as Defendant" do
      let(:proceedings) do
        [
          {
            ccms_code: "DA001",
            delegated_functions_used: false,
            client_involvement_type: "A",
          },
          {
            ccms_code: "DA005",
            delegated_functions_used: false,
            client_involvement_type: "D",
          },
        ]
      end

      it "returns valid response that includes the latest_incident_details questions" do
        expect(question_service).to eq expected_latest_incident_details_response
      end
    end

    context "when there is a Child Section 8 as Child Subject" do
      let(:proceedings) do
        [
          {
            ccms_code: "SE013",
            delegated_functions_used: true,
            client_involvement_type: "W",
          },
        ]
      end

      it "returns valid response without domestic abuse/non applicant questions" do
        expect(question_service).to eq expected_se013_child_subject_response
      end
    end

    context "with Special Children Act questions" do
      context "when there is a sole SCA core proceeding" do
        let(:proceedings) do
          [
            {
              ccms_code: "PB003",
              delegated_functions_used: false,
              client_involvement_type:,
            },
          ]
        end

        context "and the client_involvement_type is Respondent" do
          let(:client_involvement_type) { "D" }
          let(:expected_response) do
            {
              request_id:,
              success: true,
              application: {
                tasks: {
                  "opponent_name" => [],
                  "children_application" => [],
                },
              },
              proceedings: [
                {
                  ccms_code: "PB003",
                  tasks: {
                    "children_proceeding" => %w[children_application],
                    "client_relationship_to_proceeding" => [],
                  },
                },
              ],
            }
          end

          it "returns the expected questions" do
            expect(question_service).to eq expected_response
          end
        end

        context "and the client_involvement_type is Subject of proceedings (child)" do
          let(:client_involvement_type) { "W" }
          let(:expected_response) do
            {
              request_id:,
              success: true,
              application: {
                tasks: {
                  "opponent_name" => [],
                },
              },
              proceedings: [
                {
                  ccms_code: "PB003",
                  tasks: {},
                },
              ],
            }
          end

          it "returns the expected questions" do
            expect(question_service).to eq expected_response
          end
        end
      end

      context "when there are SCA core and related proceedings" do
        let(:proceedings) do
          [
            {
              ccms_code: "PB003",
              delegated_functions_used: false,
              client_involvement_type:,
            },
            {
              ccms_code: "PB007",
              delegated_functions_used: false,
              client_involvement_type:,
            },
          ]
        end

        context "and the client_involvement_type is Respondent for both" do
          let(:client_involvement_type) { "D" }
          let(:expected_response) do
            {
              request_id:,
              success: true,
              application: {
                tasks: {
                  "opponent_name" => [],
                  "children_application" => [],
                },
              },
              proceedings: [
                {
                  ccms_code: "PB003",
                  tasks: {
                    "children_proceeding" => %w[children_application],
                    "client_relationship_to_proceeding" => [],
                  },
                },
                {
                  ccms_code: "PB007",
                  tasks: {
                    "children_proceeding" => %w[children_application],
                  },
                },
              ],
            }
          end

          it "returns the expected questions" do
            expect(question_service).to eq expected_response
          end
        end

        context "and they have differing client)involvement_types" do
          let(:proceedings) do
            [
              {
                ccms_code: "PB003",
                delegated_functions_used: false,
                client_involvement_type: "W",
              },
              {
                ccms_code: "PB007",
                delegated_functions_used: false,
                client_involvement_type: "D",
              },
            ]
          end
          let(:expected_response) do
            {
              request_id:,
              success: true,
              application: {
                tasks: {
                  "opponent_name" => [],
                  "children_application" => [],
                },
              },
              proceedings: [
                {
                  ccms_code: "PB003",
                  tasks: {},
                },
                {
                  ccms_code: "PB007",
                  tasks: {
                    "children_proceeding" => %w[children_application],
                  },
                },
              ],
            }
          end

          it "returns the expected questions" do
            expect(question_service).to eq expected_response
          end
        end
      end
    end

    context "with Public Law Family questions" do
      context "when base questions only required with Child Subject of proceedings" do
        let(:ccms_code) { "PBM01" }
        let(:delegated_functions_used) { false }
        let(:client_involvement_type) { "W" }

        let(:minimum_expected_response) do
          {
            request_id:,
            success: true,
            application: {
              tasks: {
                "opponent_name" => [],
                "statement_of_case" => [],
              },
            },
            proceedings: [
              {
                ccms_code: "PBM01",
                tasks: {},
              },
            ],
          }
        end

        it "has expected public law family base questions" do
          expect(question_service).to eq(minimum_expected_response)
        end
      end

      context "when the client_involvement_type is NOT child subject of the proceedings" do
        let(:ccms_code) { "PBM01" }
        let(:delegated_functions_used) { false }
        let(:client_involvement_type) { "A" }

        it "adds children_application to ApplicationTask" do
          expect(question_service.dig(:application, :tasks)).to include({ "children_application" => [] })
        end

        it "adds children_proceeding to ProceedingTask" do
          expect(proceeding_tasks_for_ccms_code).to include({ "children_proceeding" => %w[children_application] })
        end
      end

      context "when delegated funtions used (i.e. emergency application)" do
        let(:ccms_code) { "PBM01" }
        let(:delegated_functions_used) { true }

        it "adds nature_of_urgency to ApplicationTasks" do
          expect(question_service.dig(:application, :tasks)).to include({ "nature_of_urgency" => [] })
        end
      end

      context "when client involvement type is defendant/respondent" do
        let(:ccms_code) { "PBM01" }
        let(:client_involvement_type) { "D" }

        it "adds court_order_copy to ApplicationTasks" do
          expect(question_service.dig(:application, :tasks)).to include({ "court_order_copy" => [] })
        end

        it "adds opponents_application to ProceedingTask" do
          expect(proceeding_tasks_for_ccms_code).to include({ "opponents_application" => [] })
        end
      end

      context "when proceeding type code is one of the appeal types (suffix of A)" do
        let(:ccms_code) { "PBM01A" }

        it "adds second_appeal to ApplicationTasks" do
          expect(question_service.dig(:application, :tasks)).to include({ "second_appeal" => [] })
        end

        context "and client involvement type is defendant/respondent" do
          let(:client_involvement_type) { "D" }

          it "adds court_order_copy to ApplicationTasks" do
            expect(question_service.dig(:application, :tasks)).to include({ "court_order_copy" => [] })
          end
        end

        context "and client involvement type is NOT defendant/respondent" do
          let(:client_involvement_type) { "A" }

          it "does NOT add court_order_copy to ApplicationTasks" do
            expect(question_service.dig(:application, :tasks)).not_to include({ "court_order_copy" => [] })
          end
        end
      end

      context "when proceeding type code relates to an Adoption order" do
        let(:ccms_code) { "PBM45" }

        it "adds matter_opposed to ApplicationTasks" do
          expect(question_service.dig(:application, :tasks)).to include({ "matter_opposed" => [] })
        end
      end

      context "when proceeding type code relates to an Adoption order - enforcement" do
        let(:ccms_code) { "PBM45E" }

        it "adds matter_opposed to ApplicationTasks" do
          expect(question_service.dig(:application, :tasks)).to include({ "matter_opposed" => [] })
        end
      end

      context "when proceeding type code relates to a Placement order" do
        let(:ccms_code) { "PBM40" }

        it "adds matter_opposed to ApplicationTasks" do
          expect(question_service.dig(:application, :tasks)).to include({ "matter_opposed" => [] })
        end
      end

      context "when proceeding type code relates to a Placement order - enforcement" do
        let(:ccms_code) { "PBM40E" }

        it "adds matter_opposed to ApplicationTasks" do
          expect(question_service.dig(:application, :tasks)).to include({ "matter_opposed" => [] })
        end
      end

      context "when client involvement type is applicant" do
        let(:ccms_code) { "PBM01" }
        let(:client_involvement_type) { "A" }

        it "adds chances_of_success to ProceedingTask" do
          expect(proceeding_tasks_for_ccms_code).to include({ "chances_of_success" => [] })
        end
      end

      context "when client involvement type is joined party" do
        let(:ccms_code) { "PBM01" }
        let(:client_involvement_type) { "Z" }

        it "adds chances_of_success to ProceedingTask" do
          expect(proceeding_tasks_for_ccms_code).to include({ "chances_of_success" => [] })
        end
      end

      context "when proceeding type relates to a Specific issue order" do
        let(:ccms_code) { "PBM17" }

        it "adds plf_specific_issue to ProceedingTask" do
          expect(proceeding_tasks_for_ccms_code).to include({ "plf_specific_issue" => [] })
        end
      end

      context "when proceeding type relates to a Contact with a child in care" do
        let(:ccms_code) { "PBM05" }

        it "adds plf_vary_order to ProceedingTask" do
          expect(proceeding_tasks_for_ccms_code).to include({ "plf_vary_order" => [] })
        end
      end

      context "when proceeding type relates to a Care order - discharge" do
        let(:ccms_code) { "PBM07" }

        it "adds plf_vary_order to ProceedingTask" do
          expect(proceeding_tasks_for_ccms_code).to include({ "plf_vary_order" => [] })
        end

        context "and client involvement type is Applicant" do
          let(:client_involvement_type) { "A" }

          it "adds client_child_care_assessment to ProceedingTask" do
            expect(proceeding_tasks_for_ccms_code).to include({ "client_child_care_assessment" => [] })
          end
        end

        context "and client involvement type is NOT Applicant" do
          let(:client_involvement_type) { "Z" }

          it "does not add client_child_care_assessment to ProceedingTask" do
            expect(proceeding_tasks_for_ccms_code).not_to include({ "client_child_care_assessment" => [] })
          end
        end
      end

      context "when proceeding type relates to a Revocation placement order" do
        let(:ccms_code) { "PBM33" }

        it "adds plf_vary_order to ProceedingTask" do
          expect(proceeding_tasks_for_ccms_code).to include({ "plf_vary_order" => [] })
        end
      end

      context "when proceeding type relates to a Care order" do
        let(:ccms_code) { "PBM23" }

        context "and client involvement type is Joined party" do
          let(:client_involvement_type) { "Z" }

          it "adds client_child_care_assessment to ProceedingTask" do
            expect(proceeding_tasks_for_ccms_code).to include({ "client_child_care_assessment" => [] })
          end
        end

        context "and client involvement type is NOT Joined party" do
          let(:client_involvement_type) { "A" }

          it "does not add client_child_care_assessment to ProceedingTask" do
            expect(proceeding_tasks_for_ccms_code).not_to include({ "client_child_care_assessment" => [] })
          end
        end
      end

      context "when proceeding type relates to a Special guardianship order" do
        let(:ccms_code) { "PBM32" }

        context "and client involvement type is Applicant" do
          let(:client_involvement_type) { "A" }

          it "adds client_child_care_assessment to ProceedingTask" do
            expect(proceeding_tasks_for_ccms_code).to include({ "client_child_care_assessment" => [] })
          end
        end

        context "and client involvement type is NOT Applicant" do
          let(:client_involvement_type) { "Z" }

          it "does not add client_child_care_assessment to ProceedingTask" do
            expect(proceeding_tasks_for_ccms_code).not_to include({ "client_child_care_assessment" => [] })
          end
        end
      end
    end
  end

  context "when the request fails" do
    context "when no proceedings data is supplied" do
      let(:proceedings) { [] }

      it "returns error" do
        response = question_service
        expect(response[:success]).to be false
        expect(response[:errors]).to match [/The property '#\/proceedings' did not contain a minimum number of items 1 in schema file/]
      end
    end

    context "with a non_existent client_involvement_type" do
      let(:client_involvement_type) { "X" }

      it "returns error" do
        response = question_service
        expect(response[:success]).to be false
        expect(response[:errors]).to match [/The property '#\/proceedings\/0\/client_involvement_type' value "X" did not match one of the following values: .* in schema file/]
      end
    end
  end

  def expected_latest_incident_details_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "latest_incident_details" => [],
          "client_denial_of_allegation" => [],
          "client_offer_of_undertakings" => [],
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "domestic_abuse_summary" => [],
          "statement_of_case" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "DA001",
          tasks: {
            "chances_of_success" => [],
          },
        },
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
            "opponents_application" => [],
          },
        },
      ],
    }
  end

  def expected_da005_applicant_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "latest_incident_details" => [],
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "domestic_abuse_summary" => [],
          "statement_of_case" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
          },
        },
      ],
    }
  end

  def expected_se013_child_subject_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "laspo" => [],
          "nature_of_urgency" => [],
          "opponent_mental_capacity" => [],
          "opponent_name" => [],
          "statement_of_case" => [],
          "why_matter_opposed" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "SE013",
          tasks: {
            "chances_of_success" => [],
            "attempts_to_settle" => [],
          },
        },
      ],
    }
  end

  def expected_da005_defendant_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "statement_of_case" => [],
          "client_denial_of_allegation" => [],
          "client_offer_of_undertakings" => [],
          "nature_of_urgency" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
            "opponents_application" => [],
          },
        },
      ],
    }
  end

  def expected_multiple_no_questions_response
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "latest_incident_details" => [],
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "domestic_abuse_summary" => [],
          "statement_of_case" => [],
          "children_application" => [],
          "laspo" => [],
          "nature_of_urgency" => [],
          "why_matter_opposed" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
          },
        },
        {
          ccms_code: "SE013",
          tasks: {
            "chances_of_success" => [],
            "children_proceeding" => %w[children_application],
            "attempts_to_settle" => [],
          },
        },
      ],
    }
  end

  def expected_multiple_no_questions_response_with_defendant
    {
      request_id:,
      success: true,
      application: {
        tasks: {
          "latest_incident_details" => [],
          "opponent_name" => [],
          "opponent_mental_capacity" => [],
          "domestic_abuse_summary" => [],
          "statement_of_case" => [],
          "children_application" => [],
          "laspo" => [],
          "nature_of_urgency" => [],
          "why_matter_opposed" => [],
        },
      },
      proceedings: [
        {
          ccms_code: "DA005",
          tasks: {
            "chances_of_success" => [],
          },
        },
        {
          ccms_code: "SE013",
          tasks: {
            "chances_of_success" => [],
            "children_proceeding" => %w[children_application],
            "attempts_to_settle" => [],
            "opponents_application" => [],
          },
        },
      ],
    }
  end
end
