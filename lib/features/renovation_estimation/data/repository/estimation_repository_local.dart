import '../models/estimate_models.dart';

abstract class EstimationRepository {
  Future<List<EstimateSection>> getEstimationData();
  Future<void> saveEstimation(List<EstimateSection> data);
}

// Mock implementation for now (Local Data)
class LocalEstimationRepository implements EstimationRepository {
  @override
  Future<List<EstimateSection>> getEstimationData() async {
    // Return dummy data matching your image
    return [
      EstimateSection(
          id: '1',
          title: 'Design',
          Fprize: 'F1',
          groups: [
            EstimateGroup(
                id: 'g1',
                title: 'Construction site preparation',
                items: [
                  EstimateItem(
                      id: 'i1',
                      code: 'C-AC-001',
                      description: 'Preparation and protection...',
                      unitaryPrice: 1500,
                    Fprize: "F1"
                  ),
                  EstimateItem(
                      id: 'i2',
                      code: 'C-AC-002',
                      description: 'Preparation and protection...',
                      unitaryPrice: 1500,
                      Fprize: "F1"
                  ),
                ]
            ),
          ]
      ),
      EstimateSection(
          id: '3',
          title: 'Design',
          Fprize: 'F1',
          groups: [
            EstimateGroup(
                id: 'g5',
                title: 'Construction site preparation',
                items: [
                  EstimateItem(
                      id: 'i6',
                      code: 'C-AC-001',
                      description: 'Preparation and protection...',
                      unitaryPrice: 1500,
                      Fprize: "F1"
                  ),
                  EstimateItem(
                      id: 'i7',
                      code: 'C-AC-002',
                      description: 'Preparation and protection...',
                      unitaryPrice: 1500,
                      Fprize: "F1"
                  ),
                ]
            ),
          ]
      ),
      EstimateSection(
          id: '2',
          title: 'Internal work',
          Fprize: 'F3',
          groups: [
            EstimateGroup(
                id: 'g3',
                title: 'Construction site preparation',
                items: [
                  EstimateItem(
                      id: 'i3',
                      code: 'C-AC-001',
                      description: 'Preparation and protection...',
                      unitaryPrice: 1500,
                      Fprize: "F1"
                  ),
                ]
            )
          ]
      ),
    ];
  }

  @override
  Future<void> saveEstimation(List<EstimateSection> data) async {
    // Save to GetStorage or SharedPrefs
  }
}
