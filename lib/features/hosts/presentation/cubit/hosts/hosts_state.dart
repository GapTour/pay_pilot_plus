part of 'hosts_cubit.dart';

enum HostsStatus { initial, loading, success, failure }

@immutable
class HostsState extends Equatable {
  final HostsStatus hostsStatus;
  final List<UserModel> hosts;
  final List<UserModel> allHosts;

  const HostsState({
    required this.hostsStatus,
    required this.hosts,
    required this.allHosts,
  });

  @override
  List<Object> get props => [hostsStatus, hosts, allHosts];

  HostsState copyWith({
    HostsStatus? hostsStatus,
    List<UserModel>? hosts,
    List<UserModel>? allHosts,
  }) {
    return HostsState(
      hostsStatus: hostsStatus ?? this.hostsStatus,
      hosts: hosts ?? this.hosts,
      allHosts: allHosts ?? this.allHosts,
    );
  }
}
