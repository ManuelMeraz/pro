from typing import List


def parse_settings(passed_in_settings: List[str] = []):
    if passed_in_settings is None:
        return {}

    try:
        return dict(map(lambda k_v: k_v.split("="), passed_in_settings))
    except (TypeError, ValueError):
        return {}


if __name__ == "__main__":
    assert (parse_settings(None) == {})
    assert (parse_settings(["foo=bar"]) == {"foo": "bar"})
    assert (parse_settings(["foo=bar"]) == {"foo": "bar"})
    assert (parse_settings(42) == {})
    assert (parse_settings("foo") == {})
    assert (parse_settings() == {})
