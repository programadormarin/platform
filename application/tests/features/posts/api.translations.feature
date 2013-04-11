@post @translationFixture
Feature: Testing the Translations API

    Scenario: Listing All Translations
        Given that I want to get all "Translations"
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "count" property
        And the type of the "count" property is "numeric"
        And the "count" property equals "2"
        Then the response status code should be 200

    Scenario: Listing All Translations on a non-existent Post
        Given that I want to get all "Translations"
        When I request "/posts/999/translations"
        Then the response is JSON
        And the response has a "errors" property
        Then the response status code should be 404

    Scenario: Finding a Translation
        Given that I want to find a "Translation"
        And that its "id" is "101"
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "id" property
        And the type of the "id" property is "numeric"
        Then the response status code should be 200

    Scenario: Finding a non-existent Translation
        Given that I want to find a "Translation"
        And that its "id" is "35"
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "errors" property
        Then the response status code should be 404

    Scenario: Fail to find a Report as Translation
        Given that I want to find a "Translation"
        And that its "id" is "99"
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "errors" property
        Then the response status code should be 404

    Scenario: Creating a new Translation
        Given that I want to make a new "Translation"
        And that the request "data" is:
            """
            {
                "form": 1,
                "title": "Test translation",
                "content": "Some description",
                "status": "published",
                "type": "revision",
                "locale":"de_DE",
                "values": {
                    "dummy_varchar": "testing"
                },
                "tags": ["translation-test"]
            }
            """
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "id" property
        And the type of the "id" property is "numeric"
        And the response has a "title" property
        And the "title" property equals "Test translation"
        Then the response status code should be 200

    Scenario: Creating a new Translation with same lang as original
        Given that I want to make a new "Translation"
        And that the request "data" is:
            """
            {
                "form": 1,
                "title": "Test translation",
                "content": "Some description",
                "status": "published",
                "type": "revision",
                "locale":"en_US",
                "values": {
                    "dummy_varchar": "testing"
                },
                "tags": ["translation-test"]
            }
            """
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "errors" property
        Then the response status code should be 400

    Scenario: Creating a new Translation with same lang as existing Translation
        Given that I want to make a new "Translation"
        And that the request "data" is:
            """
            {
                "form": 1,
                "title": "Test translation",
                "content": "Some description",
                "status": "published",
                "type": "revision",
                "locale":"fr_FR",
                "values": {
                    "dummy_varchar": "testing"
                },
                "tags": ["translation-test"]
            }
            """
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "errors" property
        Then the response status code should be 400

    Scenario: Updating a Translation
        Given that I want to update a "Translation"
        And that the request "data" is:
            """
            {
                "form": 1,
                "title": "Test translation updated",
                "content": "Some description",
                "status": "published",
                "type": "revision",
                "locale":"fr_FR",
                "values": {
                    "dummy_varchar": "testing"
                },
                "tags": ["translation-test"]
            }
            """
        And that its "id" is "101"
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "id" property
        And the type of the "id" property is "numeric"
        And the response has a "title" property
        And the "title" property equals "Test translation updated"
        Then the response status code should be 200

    Scenario: Updating a non-existent Translation
        Given that I want to update a "Translation"
        And that the request "data" is:
            """
            {
                "form": 1,
                "title": "Test translation updated",
                "content": "Some description",
                "status": "published",
                "type": "revision",
                "locale":"de_DE",
                "values": {
                    "dummy_varchar": "testing"
                },
                "tags": ["translation-test"]
            }
            """
        And that its "id" is "40"
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "errors" property
        Then the response status code should be 404

    Scenario: Updating a Translation with non-existent Post
        Given that I want to update a "Translation"
        And that the request "data" is:
            """
            {
                "form": 1,
                "title": "Test translation updated",
                "content": "Some description",
                "status": "published",
                "type": "revision",
                "locale":"de_DE",
                "values": {
                    "dummy_varchar": "testing"
                },
                "tags": ["translation-test"]
            }
            """
        And that its "id" is "101"
        When I request "/posts/35/translations"
        Then the response is JSON
        And the response has a "errors" property
        Then the response status code should be 404

    Scenario: Deleting a Translation
        Given that I want to delete a "Translation"
        And that its "id" is "101"
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "id" property
        Then the response status code should be 200

    Scenario: Fail to delete a non existent Translation
        Given that I want to delete a "Translation"
        And that its "id" is "200"
        When I request "/posts/99/translations"
        Then the response is JSON
        And the response has a "errors" property
        Then the response status code should be 404
