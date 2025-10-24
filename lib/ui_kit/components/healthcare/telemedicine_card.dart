import 'package:flutter/material.dart';
import '../../theme/colors/healthcare_colors.dart';
import '../../theme/typography/healthcare_typography.dart';

/// Telemedicine Card for doctor consultation apps
/// Displays doctor information and consultation options
class TelemedicineCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String? hospital;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  final String? availability;
  final double? consultationFee;
  final VoidCallback? onBookAppointment;
  final VoidCallback? onViewProfile;
  final VoidCallback? onStartConsultation;

  const TelemedicineCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    this.hospital,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    this.availability,
    this.consultationFee,
    this.onBookAppointment,
    this.onViewProfile,
    this.onStartConsultation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: HealthcareColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: HealthcareColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildDoctorInfo(),
            const SizedBox(height: 12),
            _buildRatingSection(),
            if (consultationFee != null) ...[
              const SizedBox(height: 12),
              _buildFeeSection(),
            ],
            const SizedBox(height: 12),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        _buildDoctorAvatar(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doctorName, style: HealthcareTypography.doctorName),
              Text(specialty, style: HealthcareTypography.doctorSpecialty),
              if (hospital != null) ...[
                const SizedBox(height: 2),
                Text(hospital!, style: HealthcareTypography.doctorHospital),
              ],
            ],
          ),
        ),
        if (availability != null) _buildAvailabilityBadge(),
      ],
    );
  }

  Widget _buildDoctorAvatar() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: HealthcareColors.background,
        border: Border.all(color: HealthcareColors.border),
      ),
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderAvatar(),
              ),
            )
          : _buildPlaceholderAvatar(),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: HealthcareColors.background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(
        Icons.person,
        size: 30,
        color: HealthcareColors.textSecondary,
      ),
    );
  }

  Widget _buildAvailabilityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: HealthcareColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(availability!, style: HealthcareTypography.availabilityText),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HealthcareColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildInfoRow('Specialty', specialty),
          if (hospital != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow('Hospital', hospital!),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: HealthcareTypography.infoLabel),
        Text(value, style: HealthcareTypography.infoValue),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating.floor() ? Icons.star : Icons.star_border,
              size: 16,
              color: HealthcareColors.warning,
            );
          }),
        ),
        const SizedBox(width: 8),
        Text(rating.toStringAsFixed(1), style: HealthcareTypography.ratingText),
        const SizedBox(width: 4),
        Text(
          '($reviewCount reviews)',
          style: HealthcareTypography.reviewCountText,
        ),
      ],
    );
  }

  Widget _buildFeeSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HealthcareColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: HealthcareColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Consultation Fee', style: HealthcareTypography.feeLabel),
          Text(
            '\$${consultationFee!.toStringAsFixed(2)}',
            style: HealthcareTypography.feeAmount,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onViewProfile,
            style: OutlinedButton.styleFrom(
              foregroundColor: HealthcareColors.primary,
              side: BorderSide(color: HealthcareColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('View Profile', style: HealthcareTypography.buttonText),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: onBookAppointment,
            style: ElevatedButton.styleFrom(
              backgroundColor: HealthcareColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Book Appointment',
              style: HealthcareTypography.buttonText.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Video Consultation Card for ongoing consultations
class VideoConsultationCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String? imageUrl;
  final DateTime appointmentTime;
  final String status;
  final VoidCallback? onJoinCall;
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;

  const VideoConsultationCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    this.imageUrl,
    required this.appointmentTime,
    required this.status,
    this.onJoinCall,
    this.onReschedule,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: HealthcareColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: HealthcareColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildAppointmentInfo(),
            const SizedBox(height: 12),
            _buildStatusSection(),
            const SizedBox(height: 12),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: HealthcareColors.background,
            border: Border.all(color: HealthcareColors.border),
          ),
          child: imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholderAvatar(),
                  ),
                )
              : _buildPlaceholderAvatar(),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doctorName, style: HealthcareTypography.doctorName),
              Text(specialty, style: HealthcareTypography.doctorSpecialty),
            ],
          ),
        ),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: HealthcareColors.background,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(
        Icons.person,
        size: 25,
        color: HealthcareColors.textSecondary,
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'scheduled':
        statusColor = HealthcareColors.warning;
        break;
      case 'in progress':
        statusColor = HealthcareColors.success;
        break;
      case 'completed':
        statusColor = HealthcareColors.info;
        break;
      case 'cancelled':
        statusColor = HealthcareColors.error;
        break;
      default:
        statusColor = HealthcareColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: HealthcareTypography.statusText.copyWith(color: statusColor),
      ),
    );
  }

  Widget _buildAppointmentInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HealthcareColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildInfoRow('Date', _formatDate(appointmentTime)),
          const SizedBox(height: 8),
          _buildInfoRow('Time', _formatTime(appointmentTime)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: HealthcareTypography.infoLabel),
        Text(value, style: HealthcareTypography.infoValue),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HealthcareColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: HealthcareColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.video_call, color: HealthcareColors.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Video consultation ready',
              style: HealthcareTypography.consultationText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (status.toLowerCase() == 'scheduled' ||
            status.toLowerCase() == 'in progress') ...[
          Expanded(
            child: ElevatedButton(
              onPressed: onJoinCall,
              style: ElevatedButton.styleFrom(
                backgroundColor: HealthcareColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Join Call',
                style: HealthcareTypography.buttonText.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        OutlinedButton(
          onPressed: onReschedule,
          style: OutlinedButton.styleFrom(
            foregroundColor: HealthcareColors.warning,
            side: BorderSide(color: HealthcareColors.warning),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Reschedule', style: HealthcareTypography.buttonText),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: onCancel,
          style: OutlinedButton.styleFrom(
            foregroundColor: HealthcareColors.error,
            side: BorderSide(color: HealthcareColors.error),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Cancel', style: HealthcareTypography.buttonText),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }
}

/// Health Record Card for displaying medical records
class HealthRecordCard extends StatelessWidget {
  final String recordType;
  final String title;
  final String? description;
  final DateTime date;
  final String? doctor;
  final String? hospital;
  final List<String>? attachments;
  final VoidCallback? onView;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;

  const HealthRecordCard({
    super.key,
    required this.recordType,
    required this.title,
    this.description,
    required this.date,
    this.doctor,
    this.hospital,
    this.attachments,
    this.onView,
    this.onDownload,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: HealthcareColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: HealthcareColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onView,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 12),
                _buildRecordInfo(),
                if (attachments != null && attachments!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildAttachmentsSection(),
                ],
                const SizedBox(height: 12),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: HealthcareColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getRecordIcon(),
            color: HealthcareColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: HealthcareTypography.recordTitle),
              Text(recordType, style: HealthcareTypography.recordType),
            ],
          ),
        ),
        Text(_formatDate(date), style: HealthcareTypography.recordDate),
      ],
    );
  }

  IconData _getRecordIcon() {
    switch (recordType.toLowerCase()) {
      case 'prescription':
        return Icons.medication;
      case 'lab report':
        return Icons.science;
      case 'x-ray':
        return Icons.visibility;
      case 'consultation':
        return Icons.medical_services;
      default:
        return Icons.description;
    }
  }

  Widget _buildRecordInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HealthcareColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (description != null) ...[
            _buildInfoRow('Description', description!),
            const SizedBox(height: 8),
          ],
          if (doctor != null) ...[
            _buildInfoRow('Doctor', doctor!),
            const SizedBox(height: 8),
          ],
          if (hospital != null) _buildInfoRow('Hospital', hospital!),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(label, style: HealthcareTypography.infoLabel),
        ),
        Expanded(child: Text(value, style: HealthcareTypography.infoValue)),
      ],
    );
  }

  Widget _buildAttachmentsSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HealthcareColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: HealthcareColors.info.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.attach_file, color: HealthcareColors.info, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${attachments!.length} attachment(s)',
              style: HealthcareTypography.attachmentText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onView,
            style: OutlinedButton.styleFrom(
              foregroundColor: HealthcareColors.primary,
              side: BorderSide(color: HealthcareColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('View', style: HealthcareTypography.buttonText),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: onDownload,
          style: OutlinedButton.styleFrom(
            foregroundColor: HealthcareColors.success,
            side: BorderSide(color: HealthcareColors.success),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Download', style: HealthcareTypography.buttonText),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: onShare,
          style: OutlinedButton.styleFrom(
            foregroundColor: HealthcareColors.warning,
            side: BorderSide(color: HealthcareColors.warning),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Share', style: HealthcareTypography.buttonText),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
