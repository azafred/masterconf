#!/usr/local/bin/python3
import pypd


def send_alert(desc,dedup):
    event_id = pypd.Event.create(data={
        'service_key': '9ef65f8e0f6246f9bbc3ed1e5c406a6c',
        'event_type': 'trigger',
        'dedup_key': dedup,
        'description': desc})
    return event_id['incident_key']


def resolve_alert(incident_key):
    ack = pypd.Event.create(data={
        'service_key': '9ef65f8e0f6246f9bbc3ed1e5c406a6c',
        'event_type': 'resolve',
        'incident_key': incident_key})
    return ack


def main():
    pypd.api_key = "Jc7cAMKC2C13bsS-sKhZ"
    dedup_key = 'blahblah'
    incident_ids = []
    for i in range(5):
        test_name = 'test {}'.format(i)
        id = send_alert(test_name, dedup_key)
        incident_ids.append(id)
    print("5 alerts sent to pager duty with the same dedup key... ")
    print("Incident IDs: ")
    print(' '.join(incident_ids))
    print("\n")
    while len(incident_ids) > 0:
        alert_to_resolve = incident_ids.pop()
        input("Press Enter to resolve one alert... ")
        print("  => Resolving {}".format(alert_to_resolve))
        print("\n")
        resolve_alert(alert_to_resolve)

if __name__ == "__main__":
    main()
