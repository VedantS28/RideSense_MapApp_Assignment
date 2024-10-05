import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridesense_map_app_assignment/providers/location_input_provider.dart';

/// A screen widget that allows users to input a location or use their current location.
///
/// This screen provides a search form for manual location input and quick options
/// for using the current location. It uses [LocationInputProvider] to manage its state.
class LocationInputScreen extends StatelessWidget {
  const LocationInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationInputProvider(),
      child: Consumer<LocationInputProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    // Large app bar with the title "Where to?"
                    SliverAppBar.large(
                      title: Text(
                        'Where to?',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      centerTitle: false,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          _buildSearchForm(context, provider),
                          const SizedBox(height: 24),
                          _buildOptionsDivider(context),
                          const SizedBox(height: 24),
                          _buildQuickOptions(context, provider),
                        ]),
                      ),
                    ),
                  ],
                ),
                // Loading overlay when the provider is processing a request
                if (provider.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(height: 16),
                                Text(
                                  'Finding location...',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the search form for manual location input.
  ///
  /// This form includes a text field for entering a destination and a button
  /// to submit the location and show it on the map.
  Widget _buildSearchForm(
      BuildContext context, LocationInputProvider provider) {
    return Form(
      key: provider.formKey,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text field for entering the destination
              TextFormField(
                controller: provider.locationController,
                decoration: const InputDecoration(
                  labelText: 'Enter destination',
                  hintText: 'City, address, or coordinates',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const Divider(),
              // Button to submit the location and show it on the map
              TextButton.icon(
                onPressed: provider.isLoading
                    ? null
                    : () => provider.submitLocation(context),
                icon: const Icon(Icons.map),
                label: const Text('Show on Map'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a divider with "OR" text in the middle.
  ///
  /// This divider separates the search form from the quick options.
  Widget _buildOptionsDivider(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  /// Builds the quick options section.
  ///
  /// This section includes options for quickly selecting a location,
  /// such as using the current location.
  Widget _buildQuickOptions(
      BuildContext context, LocationInputProvider provider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Quick Options',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // Option to use current location
            _buildQuickOptionTile(
              context,
              icon: Icons.my_location,
              title: 'Use Current Location',
              subtitle: 'Let us locate you automatically',
              onTap: provider.isLoading
                  ? null
                  : () => provider.getCurrentLocation(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a tile for a quick option.
  ///
  /// This tile includes an icon, title, subtitle, and onTap functionality.
  /// It's used to display individual quick options in the quick options section.
  Widget _buildQuickOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
