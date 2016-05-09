class RadonResults
  attr_accessor :results
end

FactoryGirl.define do
  factory :radon_results, class: RadonResults do
    results { {
      :mi => {
        "app/models/repository.py" => {"mi" => 100.0, "rank" => "A"}
      },
      :raw => {
        "app/models/repository.py" => {
          "loc" => 14,
          "lloc" => 10,
          "sloc" => 11,
          "multi" => 0,
          "comments" => 1,
          "blank" => 3
        }
      },
      :cc => {
        "Rakefile" => {
          "error" => "invalid syntax (<unknown>, line 4)"
        },
        "app/models/repository.py" => [
          {
            "closures" => [],
            "col_offset" => 0,
            "complexity" => 2,
            "endline" => 7,
            "lineno" => 4,
            "name" => "test",
            "rank" => "A",
            "type" => "function"
          },
          {
            "col_offset" => 4,
            "complexity" => 2,
            "endline" => 17,
            "lineno" => 10,
            "methods" => [
              {
                "classname" => "Test",
                "closures" => [],
                "col_offset" => 8,
                "complexity" => 1,
                "endline" => 12,
                "lineno" => 11,
                "name" => "method",
                "rank" => "A",
                "type" => "method"
              },
              {
                "classname" => "Test",
                "closures" => [],
                "col_offset" => 8,
                "complexity" => 2,
                "endline" => 17,
                "lineno" => 14,
                "name" => "method",
                "rank" => "A",
                "type" => "method"
              }
            ],
            "name" => "Test",
            "rank" => "A",
            "type" => "class"
          },
          {
            "classname" => "Test",
            "closures" => [],
            "col_offset" => 8,
            "complexity" => 2,
            "endline" => 17,
            "lineno" => 14,
            "name" => "method",
            "rank" => "A",
            "type" => "method"
          },
          {
            "col_offset" => 4,
            "complexity" => 2,
            "endline" => 26,
            "lineno" => 19,
            "methods" => [
              {
                "classname" => "Test",
                "closures" => [],
                "col_offset" => 8,
                "complexity" => 1,
                "endline" => 21,
                "lineno" => 20,
                "name" => "method",
                "rank" => "A",
                "type" => "method"
              },
              {
                "classname" => "Test",
                "closures" => [],
                "col_offset" => 8,
                "complexity" => 2,
                "endline" => 26,
                "lineno" => 23,
                "name" => "other_method",
                "rank" => "A",
                "type" => "method"
              }
            ],
            "name" => "Test",
            "rank" => "A",
            "type" => "class"
          },
          {
            "classname" => "Test",
            "closures" => [],
            "col_offset" => 8,
            "complexity" => 2,
            "endline" => 26,
            "lineno" => 23,
            "name" => "other_method",
            "rank" => "A",
            "type" => "method"
          },
          {
            "closures" => [],
            "col_offset" => 0,
            "complexity" => 1,
            "endline" => 2,
            "lineno" => 1,
            "name" => "test",
            "rank" => "A",
            "type" => "function"
          },
          {
            "classname" => "Test",
            "closures" => [],
            "col_offset" => 8,
            "complexity" => 1,
            "endline" => 12,
            "lineno" => 11,
            "name" => "method",
            "rank" => "A",
            "type" => "method"
          },
          {
            "classname" => "Test",
            "closures" => [],
            "col_offset" => 8,
            "complexity" => 1,
            "endline" => 21,
            "lineno" => 20,
            "name" => "method",
            "rank" => "A",
            "type" => "method"
          }
        ]
      }
    } }
  end
end
